#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Resume Loader — validation step.
#
# Loads _data/resume.yml, the single source of the experience, education,
# skills, certifications and languages of the site and of every CV, and
# checks it against the format documented in the file and in
# docs/CONTENT.md. Exits non-zero with a clear error list if anything is
# missing or malformed. Run in CI before `jekyll build`, so a broken
# resume.yml fails the deploy instead of shipping bad data.
#
# Checks: required sections; { fr, en } groups for every displayed text;
# known prefixes (profile, software, data, research); "YYYY-MM" dates;
# bullet references that point to an existing prefix of the same entry;
# ranks that are positive integers.
#
# Usage: ruby scripts/validate_resume.rb [path/to/resume.yml]

require 'yaml'
require 'date'

RESUME_PATH = ARGV[0] || File.join(__dir__, '..', '_data', 'resume.yml')
PREFIXES = %w[profile software data research].freeze
SPACES = %w[software data research].freeze
CATEGORIES = %w[professional research teaching].freeze
DATE_FORMAT = /\A\d{4}-\d{2}\z/

def fail_with(errors)
  warn "resume.yml validation failed (#{errors.size} error#{'s' if errors.size != 1}):"
  errors.each { |e| warn "  - #{e}" }
  exit 1
end

fail_with(["file not found: #{RESUME_PATH}"]) unless File.exist?(RESUME_PATH)

begin
  data = YAML.safe_load_file(RESUME_PATH, permitted_classes: [Date])
rescue Psych::SyntaxError => e
  fail_with(["invalid YAML syntax: #{e.message}"])
end

errors = []

bilingual = lambda do |value, where, required: true|
  if value.nil?
    errors << "#{where} is missing" if required
  elsif !value.is_a?(Hash) || %w[fr en].any? { |lang| value[lang].to_s.strip.empty? }
    errors << "#{where} must be a { fr, en } group with both texts"
  end
end

text_or_bilingual = lambda do |value, where|
  if value.nil? || (value.is_a?(String) && value.strip.empty?)
    errors << "#{where} is missing"
  elsif value.is_a?(Hash)
    bilingual.call(value, where)
  elsif !value.is_a?(String)
    errors << "#{where} must be a string or a { fr, en } group"
  end
end

check_date = lambda do |value, where|
  return if value.nil?

  errors << "#{where} must look like \"YYYY-MM\", got #{value.inspect}" unless value.to_s.match?(DATE_FORMAT)
end

list = lambda do |key|
  value = data[key]
  errors << "`#{key}` must be a list" unless value.is_a?(Array)
  value.is_a?(Array) ? value : []
end

# Headline and summary of each CV.
PREFIXES.each do |prefix|
  bilingual.call(data["#{prefix}_headline"], "`#{prefix}_headline`")
  bilingual.call(data["#{prefix}_summary"], "`#{prefix}_summary`")
end

list.call('experience').each_with_index do |entry, i|
  where = "`experience[#{i}]`#{" (#{entry['id']})" if entry.is_a?(Hash) && entry['id']}"
  next errors << "#{where} must be a mapping" unless entry.is_a?(Hash)

  errors << "#{where}.id is missing" if entry['id'].to_s.strip.empty?
  errors << "#{where}.category must be one of #{CATEGORIES.join(', ')}" unless CATEGORIES.include?(entry['category'])
  bilingual.call(entry['title'], "#{where}.title")
  PREFIXES.each { |prefix| bilingual.call(entry["#{prefix}_title"], "#{where}.#{prefix}_title", required: false) }
  titles = entry.keys.filter_map { |key| key.delete_suffix('_title') if key.end_with?('_title') }
  (titles - PREFIXES).each { |unknown| errors << "#{where}: unknown prefix `#{unknown}_title`" }
  text_or_bilingual.call(entry['org'], "#{where}.org")
  %w[location sector link_label].each { |key| bilingual.call(entry[key], "#{where}.#{key}", required: false) }
  errors << "#{where}.start_date is missing" if entry['start_date'].nil?
  check_date.call(entry['start_date'], "#{where}.start_date")
  check_date.call(entry['end_date'], "#{where}.end_date")

  prefixes = entry.keys.filter_map { |key| key.delete_suffix('_bullets') if key.end_with?('_bullets') }
  (prefixes - PREFIXES).each { |unknown| errors << "#{where}: unknown prefix `#{unknown}_bullets`" }
  errors << "#{where} has no <prefix>_bullets: it appears nowhere" if prefixes.empty?

  prefixes.each do |prefix|
    value = entry["#{prefix}_bullets"]
    refs = value.is_a?(String) ? [value] : Array(value)
    refs.each_with_index do |bullet, j|
      if bullet.is_a?(String)
        errors << "#{where}.#{prefix}_bullets refers to `#{bullet}`, which has no bullets here" unless prefixes.include?(bullet) && bullet != prefix
      else
        bilingual.call(bullet, "#{where}.#{prefix}_bullets[#{j}]")
      end
    end
  end

  entry.each_key do |key|
    next unless key.end_with?('_cv')

    space = key.delete_suffix('_cv')
    errors << "#{where}: unknown `#{key}`" unless SPACES.include?(space)
  end
end

list.call('education').each_with_index do |entry, i|
  where = "`education[#{i}]`"
  next errors << "#{where} must be a mapping" unless entry.is_a?(Hash)

  bilingual.call(entry['degree'], "#{where}.degree")
  errors << "#{where}.institution is missing" if entry['institution'].to_s.strip.empty?
  %w[detail research_focus supervisor].each { |key| bilingual.call(entry[key], "#{where}.#{key}", required: false) }
  errors << "#{where} needs a start_date or an end_date" if entry['start_date'].nil? && entry['end_date'].nil?
  check_date.call(entry['start_date'], "#{where}.start_date")
  check_date.call(entry['end_date'], "#{where}.end_date")
end

list.call('skills').each_with_index do |entry, i|
  where = "`skills[#{i}]`"
  next errors << "#{where} must be a mapping" unless entry.is_a?(Hash)

  bilingual.call(entry['category'], "#{where}.category")
  ranks = entry.keys.select { |key| key.end_with?('_rank') }
  errors << "#{where} has no <prefix>_rank: it appears nowhere" if ranks.empty?
  ranks.each do |key|
    errors << "#{where}: unknown prefix `#{key}`" unless PREFIXES.include?(key.delete_suffix('_rank'))
    errors << "#{where}.#{key} must be a positive integer" unless entry[key].is_a?(Integer) && entry[key].positive?
  end
  errors << "#{where}.items must be a non-empty list" unless entry['items'].is_a?(Array) && !entry['items'].empty?
  Array(entry['items']).each_with_index do |item, j|
    next unless item.is_a?(Hash)

    text_or_bilingual.call(item['name'], "#{where}.items[#{j}].name")
    (Array(item['spaces']) - SPACES).each { |unknown| errors << "#{where}.items[#{j}]: unknown space `#{unknown}`" }
  end
end

list.call('certifications').each_with_index do |entry, i|
  where = "`certifications[#{i}]`"
  next errors << "#{where} must be a mapping" unless entry.is_a?(Hash)

  errors << "#{where}.name is missing" if entry['name'].to_s.strip.empty?
  %w[detail description].each { |key| bilingual.call(entry[key], "#{where}.#{key}", required: false) }
  (Array(entry['spaces']) - SPACES).each { |unknown| errors << "#{where}: unknown space `#{unknown}`" }
end

list.call('languages').each_with_index do |entry, i|
  where = "`languages[#{i}]`"
  next errors << "#{where} must be a mapping" unless entry.is_a?(Hash)

  bilingual.call(entry['language'], "#{where}.language")
  bilingual.call(entry['level'], "#{where}.level")
end

%w[awards interests].each { |key| list.call(key) }

if errors.empty?
  puts "resume.yml is valid (#{data['experience'].size} positions, #{data['skills'].size} skill categories)."
  exit 0
else
  fail_with(errors)
end
