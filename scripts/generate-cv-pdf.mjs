#!/usr/bin/env node
// Generates the PDF CVs from the built site:
//
// - files/Profile.pdf from the dedicated /resume-print/ page (not the
//   website's /cv/ page — see _pages/resume-print.md / _layouts/resume-print.html);
// - one CV per space and language from the print pages (_layouts/cv-print.html,
//   /<space>/print/ and /en/<space>/print/), written to the file named by
//   their <meta name="cv-file">, e.g. files/CV_Laguerre_Data_FR.pdf.
//
// This is the CI-time equivalent of an on-demand PDF route: GitHub Pages
// has no server to render a PDF per request, so instead the PDFs are
// regenerated fresh from _data on every deploy. See .github/workflows/jekyll.yml.
//
// Fails (exit 1) when a space CV exceeds its <meta name="cv-max-pages">
// (tracks.yml `cv.max_pages`), when a print page references an id that
// matches nothing in _data (data-cv-missing), or when no print page is found.
//
// Usage: node scripts/generate-cv-pdf.mjs [siteDir] [port]
//   siteDir defaults to ./_site (the Jekyll build output)
//   port defaults to 4173

import { chromium } from 'playwright';
import { createServer } from 'http-server';
import { existsSync } from 'node:fs';
import { mkdir, readdir, readFile } from 'node:fs/promises';
import path from 'node:path';

const siteDir = path.resolve(process.argv[2] || '_site');
const port = Number(process.argv[3] || 4173);
const filesDir = path.join(siteDir, 'files');

if (!existsSync(siteDir)) {
  console.error(`Site directory not found: ${siteDir}. Run "bundle exec jekyll build" first.`);
  process.exit(1);
}

const server = createServer({ root: siteDir, cache: -1 });

// Margins are defined once, in each print stylesheet's @page rule —
// preferCSSPageSize lets that be the single source of truth instead of
// stacking a second margin here.
const pdfOptions = { format: 'A4', printBackground: true, preferCSSPageSize: true };

// Print pages of the spaces: every built index.html carrying <meta name="cv-file">.
async function findPrintPages(dir) {
  const found = [];
  for (const entry of await readdir(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      found.push(...(await findPrintPages(full)));
    } else if (entry.name === 'index.html') {
      const html = await readFile(full, 'utf8');
      const file = html.match(/<meta name="cv-file" content="([^"]+)"/);
      if (!file) continue;
      const maxPages = Number(html.match(/<meta name="cv-max-pages" content="(\d+)"/)?.[1]);
      const urlPath = '/' + path.relative(siteDir, path.dirname(full)).split(path.sep).join('/') + '/';
      found.push({ urlPath, file: file[1], maxPages });
    }
  }
  return found;
}

// Number of pages of a PDF produced by Chromium: page objects are plain
// dictionaries ("/Type /Page"), distinct from the page tree ("/Type /Pages").
function countPages(buffer) {
  return (buffer.toString('latin1').match(/\/Type\s*\/Page(?![a-zA-Z])/g) || []).length;
}

async function main() {
  await new Promise((resolve) => server.listen(port, resolve));
  console.log(`Serving ${siteDir} at http://localhost:${port}`);
  await mkdir(filesDir, { recursive: true });

  const failures = [];
  const browser = await chromium.launch();
  try {
    const page = await browser.newPage();

    await page.goto(`http://localhost:${port}/resume-print/`, { waitUntil: 'networkidle' });
    const profilePath = path.join(filesDir, 'Profile.pdf');
    await page.pdf({ path: profilePath, ...pdfOptions });
    console.log(`Generated ${profilePath}`);

    const printPages = await findPrintPages(siteDir);
    if (printPages.length === 0) failures.push('no CV print page found (<meta name="cv-file">)');

    for (const cv of printPages) {
      await page.goto(`http://localhost:${port}${cv.urlPath}`, { waitUntil: 'networkidle' });

      const missing = await page.$$eval('[data-cv-missing]', (nodes) => nodes.map((n) => n.dataset.cvMissing));
      if (missing.length > 0) failures.push(`${cv.urlPath}: unknown id(s) in tracks.yml cv block: ${missing.join(', ')}`);

      const outputPath = path.join(filesDir, cv.file);
      const buffer = await page.pdf({ path: outputPath, ...pdfOptions });
      const pages = countPages(buffer);
      console.log(`Generated ${outputPath} (${pages} page${pages > 1 ? 's' : ''}, max ${cv.maxPages})`);

      if (!Number.isInteger(cv.maxPages) || cv.maxPages < 1) {
        failures.push(`${cv.urlPath}: missing cv-max-pages`);
      } else if (pages > cv.maxPages) {
        failures.push(`${cv.file}: ${pages} pages, the limit is ${cv.maxPages}`);
      }
    }
  } finally {
    await browser.close();
    server.close();
  }

  if (failures.length > 0) {
    console.error(`\nCV generation failed:\n- ${failures.join('\n- ')}`);
    process.exit(1);
  }
}

main().catch((err) => {
  console.error(err);
  server.close();
  process.exit(1);
});
