# Geovany Batista Polo LAGUERRE — Personal Academic Website

[![Website](https://img.shields.io/badge/Website-geobatpo.github.io-0A66C2?style=for-the-badge&logo=google-chrome&logoColor=white)](https://geobatpo.github.io)
[![GitHub Pages](https://img.shields.io/github/actions/workflow/status/Geobatpo07/geobatpo.github.io/jekyll.yml?branch=main&style=for-the-badge&label=GitHub%20Pages)](https://github.com/Geobatpo07/geobatpo.github.io/actions/workflows/jekyll.yml)
[![Scrape Talks](https://img.shields.io/github/actions/workflow/status/Geobatpo07/geobatpo.github.io/scrape_talks.yml?branch=main&style=for-the-badge&label=Scrape%20Talks)](https://github.com/Geobatpo07/geobatpo.github.io/actions/workflows/scrape_talks.yml)
[![Jekyll](https://img.shields.io/badge/Jekyll-Static%20Site-CC0000?style=for-the-badge&logo=jekyll&logoColor=white)](https://jekyllrb.com)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com)
[![Repo Size](https://img.shields.io/github/repo-size/Geobatpo07/geobatpo.github.io?style=for-the-badge)](https://github.com/Geobatpo07/geobatpo.github.io)
[![License](https://img.shields.io/github/license/Geobatpo07/geobatpo.github.io?style=for-the-badge)](LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/Geobatpo07/geobatpo.github.io?style=for-the-badge)](https://github.com/Geobatpo07/geobatpo.github.io/commits/main)
[![GitHub Profile](https://img.shields.io/badge/GitHub-@Geobatpo07-181717?style=for-the-badge&logo=github)](https://github.com/Geobatpo07)

This repository contains my personal academic and professional website, published at:

**https://geobatpo.github.io**

Built with Jekyll (Academic Pages / Minimal Mistakes), the site presents my work in data science, applied mathematics, teaching, and research projects.

## Main Sections

- Home / About
- Publications
- Teaching
- Supervisors
- Portfolio
- CV

## Tech Stack

- Jekyll + Academic Pages
- Ruby + Bundler
- Docker / Docker Compose (recommended for local development)
- SCSS for theme customization

## Run Locally (Recommended)

From the project root:

```bash
docker compose up --build
```

Then open:

```text
http://localhost:4000
```

To stop:

```bash
docker compose down
```

## Quick Content Editing Guide

- Site-wide settings: `_config.yml`
- Top navigation: `_data/navigation.yml`
- About page: `_pages/about.md`
- CV page: `_pages/cv.md`
- Supervisors page data: `_data/supervisors.yml`
- Publications entries: `_publications/`
- Teaching entries: `_teaching/`
- Portfolio entries: `_portfolio/`

## Project Structure (Key Paths)

```text
_pages/           Static pages (about, cv, supervisors, etc.)
_data/            YAML data files (navigation, supervisors, ui labels)
_publications/    Publication records
_teaching/        Teaching records
_portfolio/       Portfolio project records
_sass/            Theme and layout styling
assets/           Front-end assets (css/js/fonts)
files/            Downloadable files (papers/slides/etc.)
```

## Notes

- The repository started from the Academic Pages template and is now customized for my own content.
- Local testing is validated with Docker and HTTP checks on key routes.
- The `supervisors` section is data-driven from `_data/supervisors.yml`.

## License

This project follows the original template license terms (see `LICENSE`) plus my own content ownership for added materials.
