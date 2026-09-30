# frozen_string_literal: true

require "cgi"
require "nokogiri"

# Liquid filter `nowrap_hyphens`, used by the print CVs (_layouts/cv-print.html).
#
# Chromium may break a line after a hyphen ("Scikit-" / "learn"); PDF text
# extraction, as done by applicant tracking systems, then glues or splits
# the name. The filter wraps every hyphenated word of the text nodes
# ("Scikit-learn", "Lax-Friedrichs", "DP-700") in <span class="nowrap">,
# styled white-space: nowrap in assets/css/cv-print.scss. The hyphen stays a
# normal hyphen. Attributes and link text (URLs) are left untouched.
module Jekyll
  module NowrapHyphensFilter
    HYPHENATED = /(?<![[:alnum:]\/.@-])([[:alnum:]][[:alnum:]+#]*(?:-[[:alnum:]][[:alnum:]+#]*)+)/

    def nowrap_hyphens(input)
      fragment = Nokogiri::HTML::DocumentFragment.parse(input.to_s)
      text_nodes = []
      fragment.traverse { |node| text_nodes << node if node.text? }
      text_nodes.each do |node|
        next if node.ancestors.any? { |a| a.element? && (%w[a script style].include?(a.name) || a["class"].to_s.split.include?("nowrap")) }
        next unless node.text.match?(HYPHENATED)

        html = CGI.escapeHTML(node.text).gsub(HYPHENATED) { %(<span class="nowrap">#{Regexp.last_match(1)}</span>) }
        node.replace(Nokogiri::HTML::DocumentFragment.parse(html))
      end
      fragment.to_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::NowrapHyphensFilter)
