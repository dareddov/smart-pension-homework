require 'set'
class MostVisitedPages
  def initialize(file_content)
    @file_content = file_content
    @page_views = Hash.new(0)
    @unique_views = Hash.new { |hash, key| hash[key] = Set.new }
  end

  def show
    parse_file_content
    print_results
  end

  private

  attr_reader :file_content, :page_views, :unique_views

  def parse_file_content
    file_content.each_line.with_object(Hash.new { |hash, key| hash[key] = [] }) do |line, hash|
      page, ip = line.strip.split

      page_views[page] += 1
      unique_views[page].add(ip)
    end
  end

  def print_results
    puts '### list of webpages with most page views ordered from most pages views to less page views'

    page_views.sort_by { |_, count| -count }.each do |page, count|
      puts "#{page} #{count} views"
    end

    puts '### list of webpages with most unique page views'

    unique_views.sort_by { |_, ips| -ips.size }.each do |page, ips|
      puts "#{page} #{ips.size} unique views"
    end
  end
end

if ARGV.length != 1
  puts 'Usage: ruby parser.rb <file_contentname>'
  exit
end

begin
  file_content = File.read(file_content = ARGV[0])
  MostVisitedPages.new(file_content).show
rescue => error
  puts "An error occurred while reading the file_content: #{error.message}"
  exit
end
