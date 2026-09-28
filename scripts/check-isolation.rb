# frozen_string_literal: true

# Runs html-proofer on the built site with one extra check, SpaceIsolation:
#
#   - every HTML page declares its chrome in <html data-space="...">:
#     software, data, research (the three spaces), portal or neutral;
#     only jekyll-redirect-from stubs may omit it;
#   - no page contains the former global header (.masthead, .site-header);
#   - a page of a space never links to the portal or to another space.
#     Links are followed through redirect stubs; links to neutral pages,
#     to files and to other sites are allowed;
#   - languages: French at the root, English under /en/. Every English page
#     lives under /en/ and has a French version (an hreflang="fr"
#     alternate that exists in the build); a FR/EN pair lists both hreflang
#     alternates with x-default on the French page; no link uses the former
#     /fr/ prefix.
#
# Usage: bundle exec ruby scripts/check-isolation.rb [site_dir]   (default _site)
# Exits non-zero when html-proofer reports a failure or when fewer than
# MIN_CHECKED_FILES HTML files were checked.

require "html-proofer"
require "nokogiri"
require "uri"

SITE_DIR = File.expand_path(ARGV[0] || "_site")
SITE_HOSTS = %w[geovanylaguerre.net www.geovanylaguerre.net].freeze
SPACES = %w[software data research].freeze
CHROMES = (SPACES + %w[portal neutral]).freeze
LEGACY_HEADER = ".masthead, .site-header"

# Guard: fail when fewer HTML files than this were actually checked, so a
# broken build or a silent html-proofer failure cannot pass as a success.
MIN_CHECKED_FILES = 50

# Number of HTML files that went through the checks (set by process_files).
module CheckedFiles
  class << self
    attr_accessor :count
  end
end

# html-proofer 5 loads files inside an Async reactor; with Ruby 3.1 and
# async 2.24 no task runs, so every check passes on zero files. Load the
# files sequentially instead (the site has a few dozen pages), and count them.
module HTMLProofer
  class Runner
    def process_files
      loaded = files.map { |file| load_file(file[:path], file[:source]) }
      CheckedFiles.count = loaded.size
      @logger.log(:info, "Checked #{loaded.size} HTML files (minimum #{MIN_CHECKED_FILES})")
      if loaded.size < MIN_CHECKED_FILES
        @logger.log(:fatal, "Only #{loaded.size} HTML files checked, expected at least #{MIN_CHECKED_FILES}")
        exit(1)
      end
      loaded
    end
  end
end

# Maps each URL path of the built site to its page: data-space, and the
# redirect target for jekyll-redirect-from stubs.
module SitePages
  module_function

  def index
    @index ||= Dir.glob(File.join(SITE_DIR, "**", "*.html")).each_with_object({}) do |file, pages|
      doc = Nokogiri::HTML(File.read(file))
      refresh = doc.at('meta[http-equiv="refresh"]')&.[]("content")
      entry = {
        space: doc.at("html")&.[]("data-space"),
        redirect: refresh && refresh[/url=\s*(\S+)/i, 1]
      }
      rel = "/#{file.delete_prefix("#{SITE_DIR}/")}"
      keys = if rel.end_with?("/index.html")
               dir = rel.delete_suffix("index.html")
               [rel, dir, dir.chomp("/")]
             else
               [rel, rel.delete_suffix(".html")]
             end
      keys.each { |key| pages[key] = entry unless key.empty? }
    end
  end

  # URL path of a built file, "/data/index.html" -> "/data/".
  def url_of(filename)
    rel = "/#{File.expand_path(filename).delete_prefix("#{SITE_DIR}/")}"
    rel.end_with?("/index.html") ? rel.delete_suffix("index.html") : rel
  end

  # Internal path of an href relative to the page at base_path, or nil for
  # other sites, mail links and same-page anchors.
  def internal_path(href, base_path)
    return nil if href.empty? || href.start_with?("#", "mailto:", "tel:", "javascript:")

    uri = URI.join("https://#{SITE_HOSTS.first}#{base_path}", href)
    return nil unless %w[http https].include?(uri.scheme) && SITE_HOSTS.include?(uri.host)

    uri.path.empty? ? "/" : uri.path
  rescue URI::Error
    nil
  end

  # data-space of the page a path ends on, following redirect stubs.
  def space_of(path, seen = [])
    entry = index[path]
    return nil if entry.nil? || seen.include?(path)
    return entry[:space] unless entry[:redirect]

    target = internal_path(entry[:redirect], path)
    target ? space_of(target, seen + [path]) : nil
  end
end

class SpaceIsolation < HTMLProofer::Check
  def run
    root = @html.at("html")
    space = root&.[]("data-space")
    redirect_stub = @html.at('meta[http-equiv="refresh"]')

    if space.nil?
      add_failure("page has no data-space and is not a redirect", line: root&.line) unless redirect_stub
      return
    end
    add_failure("unknown data-space \"#{space}\"", line: root.line) unless CHROMES.include?(space)

    @html.css(LEGACY_HEADER).each do |node|
      add_failure("former global header (.#{node["class"].split.first}) still present", line: node.line)
    end

    base_path = SitePages.url_of(@runner.current_filename)
    check_language(root, base_path)
    check_no_fr_prefix(base_path)

    return unless SPACES.include?(space)

    @html.css("a[href]").each do |node|
      path = SitePages.internal_path(node["href"].strip, base_path)
      next if path.nil?

      target = SitePages.space_of(path)
      next unless target == "portal" || (SPACES.include?(target) && target != space)

      add_failure("#{space} page links to the #{target == "portal" ? "portal" : "#{target} space"}: #{node["href"]}",
                  line: node.line, content: node.to_html)
    end
  end

  private

  def check_language(root, base_path)
    lang = root["lang"]
    alternates = @html.css('link[rel="alternate"][hreflang]').to_h { |l| [l["hreflang"], l["href"]] }

    if lang == "en"
      add_failure("English page outside /en/", line: root.line) unless base_path.start_with?("/en/")
      french = alternates["fr"] && SitePages.internal_path(alternates["fr"], base_path)
      if french.nil?
        add_failure("English page without a French version (no hreflang=\"fr\" alternate)", line: root.line)
      elsif SitePages.index[french].nil?
        add_failure("French version #{french} does not exist", line: root.line)
      end
    elsif base_path.start_with?("/en/")
      add_failure("page under /en/ has lang=\"#{lang}\"", line: root.line)
    elsif lang != "fr"
      add_failure("unexpected lang=\"#{lang}\"", line: root.line)
    end

    return unless alternates.key?("fr") && alternates.key?("en")
    return if alternates["x-default"] == alternates["fr"]

    add_failure("hreflang x-default must point to the French version (#{alternates["fr"]})", line: root.line)
  end

  def check_no_fr_prefix(base_path)
    @html.css("a[href]").each do |node|
      path = SitePages.internal_path(node["href"].strip, base_path)
      next unless path&.start_with?("/fr/") || path == "/fr"

      add_failure("link uses the former /fr/ prefix: #{node["href"]}", line: node.line, content: node.to_html)
    end
  end
end

abort "#{SITE_DIR} not found; run jekyll build first" unless Dir.exist?(SITE_DIR)

proofer = HTMLProofer.check_directory(
  SITE_DIR,
  checks: %w[Links Images Scripts SpaceIsolation],
  disable_external: true,
  allow_missing_href: true,
  swap_urls: { %r{\Ahttps?://(www\.)?geovanylaguerre\.net} => "" }
)
proofer.run

# process_files did not run (html-proofer internals changed): the count guard
# was bypassed, so do not report a success.
abort "No file count recorded; the file-count guard did not run" if CheckedFiles.count.nil?
