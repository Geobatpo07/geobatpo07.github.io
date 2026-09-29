# frozen_string_literal: true
#
# CV PDF
# ======
# Renders the eight PDF CVs from the print pages once the site is written
# (hook :site, :post_write), with Chrome headless driven by Ferrum:
#
#   /resume-print/, /en/resume-print/   files/Profile.pdf, files/Profile_EN.pdf
#   /<space>/print/, /en/<space>/print/ files/<tracks.yml cv_file>_<FR|EN>.pdf
#
# The print pages are served from the destination folder over a local HTTP
# server, so their root-relative CSS and font URLs resolve as on the site.
# Margins and page size come from each print stylesheet's @page rule
# (prefer_css_page_size), never from here.
#
# The build fails (Jekyll::Errors::FatalException) when:
#   - Chrome or Chromium cannot be found (set BROWSER_PATH to its binary);
#   - one of the eight print pages is missing;
#   - a print page carries a data-cv-missing marker (unknown id in a
#     tracks.yml cv block);
#   - a space CV has more pages than tracks.yml `cv.max_pages`, counted
#     with pdf-reader.
#
# Local development: `cv_pdf: false` in a config file, or CV_PDF=0 in the
# environment, skips the generation (e.g. during `jekyll serve`). Both are
# ignored in production (JEKYLL_ENV=production) and in CI (CI=true), where
# the PDFs are always generated.

require 'fileutils'
require 'stringio'
require 'webrick'
require 'ferrum'
require 'pdf-reader'

module CvPdf
  LANGS = %w[fr en].freeze
  PROFILE_FILES = { 'fr' => 'Profile.pdf', 'en' => 'Profile_EN.pdf' }.freeze
  PDF_OPTIONS = { format: :A4, print_background: true, prefer_css_page_size: true }.freeze
  # Same viewport as the former Playwright script, for identical output.
  WINDOW_SIZE = [1280, 720].freeze
  TIMEOUT = 60

  # One PDF to render: the print page URL, the output file name and, for a
  # space CV, its page limit (nil for the complete CV, which has none).
  Job = Struct.new(:url, :file, :max_pages)

  class Generator
    def initialize(site)
      @site = site
      @failures = []
    end

    def self.enabled?(site)
      return true if ENV['JEKYLL_ENV'] == 'production' || ENV['CI'] == 'true'
      return false if %w[0 false no].include?(ENV['CV_PDF'].to_s.downcase)

      site.config['cv_pdf'] != false
    end

    def run
      jobs = collect_jobs
      fail_build if @failures.any?

      files_dir = File.join(@site.dest, 'files')
      FileUtils.mkdir_p(files_dir)

      with_server do |base_url|
        with_browser do |browser|
          jobs.each { |job| render(browser, base_url, job, files_dir) }
        end
      end

      fail_build if @failures.any?
    end

    private

    # The eight print pages, found from the site's pages: resume-print for
    # the complete CV, cv-print for the space CVs (space and lang from the
    # front matter). A missing one fails the build rather than being skipped.
    def collect_jobs
      tracks = @site.data['tracks'] || {}
      jobs = []

      LANGS.each do |lang|
        profile = print_page('resume-print', lang)
        if profile
          jobs << Job.new(profile.url, PROFILE_FILES[lang], nil)
        else
          @failures << "no resume-print page for lang #{lang}"
        end

        tracks.each do |space, track|
          page = print_page('cv-print', lang, space)
          unless page
            @failures << "no cv-print page for space #{space}, lang #{lang}"
            next
          end

          max_pages = track.dig('cv', 'max_pages')
          unless max_pages.is_a?(Integer) && max_pages.positive?
            @failures << "tracks.yml #{space}.cv.max_pages is missing or not a positive integer"
            next
          end

          jobs << Job.new(page.url, "#{track['cv_file']}_#{lang.upcase}.pdf", max_pages)
        end
      end

      jobs
    end

    def print_page(layout, lang, space = nil)
      @site.pages.find do |page|
        page.data['layout'] == layout &&
          (page.data['lang'] || 'fr') == lang &&
          (space.nil? || page.data['space'] == space)
      end
    end

    def render(browser, base_url, job, files_dir)
      browser.goto(base_url + job.url)
      browser.network.wait_for_idle(timeout: TIMEOUT)
      browser.evaluate_async('document.fonts.ready.then(() => arguments[0](true))', TIMEOUT)

      missing = browser.evaluate(
        "Array.from(document.querySelectorAll('[data-cv-missing]')).map((n) => n.dataset.cvMissing)"
      )
      @failures << "#{job.url}: unknown id(s) in tracks.yml cv block: #{missing.join(', ')}" if missing.any?

      pdf = browser.pdf(encoding: :binary, timeout: TIMEOUT, **PDF_OPTIONS)
      File.binwrite(File.join(files_dir, job.file), pdf)
      pages = PDF::Reader.new(StringIO.new(pdf)).page_count

      limit = job.max_pages ? ", max #{job.max_pages}" : ''
      Jekyll.logger.info 'CV PDF:', "files/#{job.file} (#{pages} page#{'s' if pages > 1}#{limit})"

      return unless job.max_pages && pages > job.max_pages

      @failures << "files/#{job.file}: #{pages} pages, the limit is #{job.max_pages} " \
                   '(tracks.yml cv.max_pages); shorten the CV in _data/resume.yml or _data/tracks.yml'
    end

    # Serves the destination folder on a free local port for the duration
    # of the block.
    def with_server
      server = WEBrick::HTTPServer.new(
        BindAddress: '127.0.0.1', Port: 0, DocumentRoot: @site.dest,
        Logger: WEBrick::Log.new(File::NULL), AccessLog: []
      )
      thread = Thread.new { server.start }
      yield "http://127.0.0.1:#{server.config[:Port]}"
    ensure
      server&.shutdown
      thread&.join
    end

    def with_browser
      browser = Ferrum::Browser.new(
        headless: true, timeout: TIMEOUT, window_size: WINDOW_SIZE,
        # Chrome's sandbox needs kernel features that containers and CI
        # runners often lack; the pages rendered are the site's own.
        browser_options: { 'no-sandbox' => nil }
      )
      yield browser
    rescue Ferrum::BinaryNotFoundError => e
      raise Jekyll::Errors::FatalException,
            "CV PDF: Chrome or Chromium not found (#{e.message}). Install it, or set BROWSER_PATH " \
            'to its binary. To skip the PDFs in local development only, set CV_PDF=0 or cv_pdf: false.'
    ensure
      browser&.quit
    end

    def fail_build
      raise Jekyll::Errors::FatalException, "CV PDF generation failed:\n- #{@failures.join("\n- ")}"
    end
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  if CvPdf::Generator.enabled?(site)
    CvPdf::Generator.new(site).run
  else
    Jekyll.logger.info 'CV PDF:', 'skipped (cv_pdf: false or CV_PDF=0)'
  end
end
