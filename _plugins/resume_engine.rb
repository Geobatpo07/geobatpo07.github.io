# frozen_string_literal: true
#
# Resume Engine
# =============
# Prepares `_data/resume.yml`, the single source of the experience,
# education, skills, certifications and languages shown on the site and in
# every CV, so templates never compute anything themselves. Runs once per
# build, before pages are rendered, and derives:
#
#   entry['on']       prefixes where an entry appears (profile, software,
#                     data, research): experience with a <prefix>_bullets
#                     key, skills with a <prefix>_rank, certifications in
#                     `spaces` (plus profile), education everywhere
#   entry['cv_on']    the same, minus the spaces marked <space>_cv: false
#   entry['<prefix>_bullets']  resolved: a reference to another prefix
#                     (`profile_bullets: research` or [data, software])
#                     is replaced by that prefix's bullets
#   entry['dates']    { fr, en } display labels from start_date / end_date
#                     ("juil. 2023 – août 2026", "May 2025 – present")
#   resume['timeline']               { fr: [...], en: [...] } merged, sorted
#                                    milestones (experience, education,
#                                    published outputs of that language)
#   resume['total_years_experience'] integer
#
# Month names and labels come from _data/i18n.yml. No presentation logic.

module ResumeEngine
  PREFIXES = %w[profile software data research].freeze
  SPACES = %w[software data research].freeze
  LANGS = %w[fr en].freeze
  PREPARATION_MARKERS = ['in preparation', 'en preparation', 'en préparation'].freeze

  class Generator < Jekyll::Generator
    priority :high

    def generate(site)
      resume = site.data['resume']
      return unless resume

      @i18n = site.data['i18n'] || {}

      Array(resume['experience']).each { |entry| prepare_experience(entry) }
      Array(resume['education']).each do |entry|
        entry['on'] = PREFIXES.dup
        entry['cv_on'] = PREFIXES.dup
        entry['dates'] = date_labels(entry)
        entry['years'] = year_label(entry)
      end
      Array(resume['skills']).each { |entry| prepare_ranked(entry) }
      Array(resume['certifications']).each { |entry| prepare_certification(entry) }

      publications = site.collections['publications']&.docs || []
      resume['timeline'] = LANGS.to_h { |lang| [lang, build_timeline(resume, publications, lang)] }
      resume['total_years_experience'] = total_years_experience(resume)
    end

    private

    def prepare_experience(entry)
      on = PREFIXES.select { |prefix| entry.key?("#{prefix}_bullets") }
      on.each do |prefix|
        entry["#{prefix}_bullets"] = resolve_bullets(entry, prefix, [])
      end
      entry['on'] = on
      entry['cv_on'] = on.reject { |prefix| entry["#{prefix}_cv"] == false }
      entry['dates'] = date_labels(entry)
    end

    # A bullets value is a list of { fr, en }, or the name of another prefix
    # (or a list of names) whose bullets it reuses.
    def resolve_bullets(entry, prefix, seen)
      value = entry["#{prefix}_bullets"]
      refs = value.is_a?(String) ? [value] : Array(value)
      return refs if refs.none? { |item| item.is_a?(String) }

      refs.flat_map do |ref|
        next [ref] unless ref.is_a?(String)
        next [] if seen.include?(ref) || !entry.key?("#{ref}_bullets")

        resolve_bullets(entry, ref, seen + [prefix])
      end
    end

    def prepare_ranked(entry)
      on = PREFIXES.select { |prefix| entry.key?("#{prefix}_rank") }
      entry['on'] = on
      entry['cv_on'] = on.reject { |prefix| entry["#{prefix}_cv"] == false }
    end

    def prepare_certification(entry)
      on = ['profile'] + (Array(entry['spaces']) & SPACES)
      entry['on'] = on
      entry['cv_on'] = on.reject { |prefix| entry["#{prefix}_cv"] == false }
    end

    # { fr, en } labels: "start – end", "start – present", or a single date
    # when there is no start or start equals end.
    def date_labels(entry)
      start = entry['start_date']&.to_s
      finish = entry['end_date']&.to_s
      LANGS.to_h do |lang|
        label =
          if start.nil? || start == finish
            month_label(finish || start, lang)
          else
            "#{month_label(start, lang)} – #{finish ? month_label(finish, lang) : t(lang, 'present')}"
          end
        [lang, label]
      end
    end

    # Years only ("2024 – 2026", "2024"), for the compact education lists
    # of the space pages and space CVs.
    def year_label(entry)
      start = entry['start_date']&.to_s&.split('-')&.first
      finish = entry['end_date']&.to_s&.split('-')&.first
      return finish || start if start.nil? || finish.nil? || start == finish

      "#{start} – #{finish}"
    end

    def month_label(value, lang)
      return '' if value.nil?

      year, month = value.split('-')
      return year if month.nil?

      months = t(lang, 'months') || []
      "#{months[month.to_i - 1]} #{year}".strip
    end

    def t(lang, key)
      @i18n.dig(lang, key)
    end

    def timeline_label(lang, key)
      @i18n.dig(lang, 'timeline', key) || key
    end

    # Experience, education and published outputs of one language, newest first.
    def build_timeline(resume, publications, lang)
      entries = []

      Array(resume['experience']).each do |e|
        next if e['include_in_timeline'] == false

        entries << {
          'date' => e.dig('dates', lang),
          'sort_key' => e['start_date'].to_s,
          'category' => timeline_label(lang, e['category'] || 'professional'),
          'title' => localized(e['title'], lang),
          'description' => localized(e['org'], lang)
        }
      end

      Array(resume['education']).each do |e|
        next if e['include_in_timeline'] == false

        entries << {
          'date' => e.dig('dates', lang),
          'sort_key' => (e['start_date'] || e['end_date']).to_s,
          'category' => timeline_label(lang, 'education'),
          'title' => localized(e['degree'], lang),
          'description' => [e['institution'], localized(e['detail'], lang)].reject(&:empty?).join(', ')
        }
      end

      publications.each do |pub|
        next unless (pub.data['lang'] || 'fr') == lang
        next if in_preparation?(pub)

        entries << {
          'date' => month_label(pub.date.strftime('%Y-%m'), lang),
          'sort_key' => pub.date.strftime('%Y-%m'),
          'category' => timeline_label(lang, 'output'),
          'title' => "#{timeline_label(lang, output_kind(pub))}#{lang == 'en' ? ': ' : ' : '}#{pub.data['title']}",
          'description' => pub.data['excerpt'].to_s
        }
      end

      entries.sort_by { |e| e['sort_key'] }.reverse
    end

    def localized(value, lang)
      value.is_a?(Hash) ? value[lang].to_s : value.to_s
    end

    def in_preparation?(pub)
      haystack = "#{pub.data['venue']} #{pub.data['title']}".downcase
      PREPARATION_MARKERS.any? { |marker| haystack.include?(marker) }
    end

    def output_kind(pub)
      venue = pub.data['venue'].to_s.downcase
      return 'preprint' if venue.include?('preprint') || venue.include?('prépublication')
      return 'presentation' if venue.include?('presentation') || venue.include?('présentation')

      'publication'
    end

    # Total distinct years covered by the dated experience, from the earliest
    # start_date through today (or the latest end_date if all have ended).
    def total_years_experience(resume)
      starts = []
      ends = []

      Array(resume['experience']).each do |e|
        next unless e['start_date']

        starts << Date.strptime("#{e['start_date']}-01", '%Y-%m-%d')
        ends << (e['end_date'] ? Date.strptime("#{e['end_date']}-01", '%Y-%m-%d') : Date.today)
      end

      return nil if starts.empty?

      ((ends.max - starts.min) / 365.25).floor
    end
  end
end
