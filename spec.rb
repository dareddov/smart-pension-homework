require 'rspec'
require_relative 'parser'

describe MostVisitedPages do
  it 'list of webpages with most page views ordered from most pages views to less page views from given file and list of webpages with most unique page views from given file' do
    file = "/test/1 1.1.1.1\n/contact 2.2.2.2\n/home 5.5.5.5\n/about/2 3.3.3.3\n/test/1 1.1.1.1\n/test/1 1.1.1.2\n"

    message = <<~TEXT
      ### list of webpages with most page views ordered from most pages views to less page views
      /test/1 3 views
      /contact 1 views
      /home 1 views
      /about/2 1 views
      ### list of webpages with most unique page views
      /test/1 2 unique views
      /contact 1 unique views
      /home 1 unique views
      /about/2 1 unique views
    TEXT

    expect { MostVisitedPages.new(file).show }.to output(message).to_stdout
  end
end
