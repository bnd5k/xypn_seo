require 'nokogiri'
require 'rest-client'

module HTMLCleaner
  def self.clean(html_string)
    clean_string = remove_any_white_space_between_tags(condense_whitespace(html_string)).strip
  end

  private

  def self.remove_any_white_space_between_tags(html_string)
    html_string.gsub(/(?<=>)\s+(?=<)/, "")
  end

  def self.condense_whitespace(html_string)
    html_string.gsub(/\s+/, ' ')
  end
end

class PageParser
  attr_reader :noko_doc

  def initialize(html_string)
    @noko_doc = create_nokogiri_doc(html_string)
  end

  # returns an array of all XYPN advisor profile URLs
  def parse_advisor_list
    parse_urls
  end

  # currently just returns a specific advisors personal URL
  def parse_advisor_page
    parse_page
  end

  private

  def create_nokogiri_doc(html_string)
    clean_html = HTMLCleaner.clean(html_string)
    Nokogiri::HTML(clean_html)
  end

  def parse_urls
    @noko_doc.xpath('//h3/a/@href').map do | noko_el |
      noko_el.value
    end
  end

  def parse_page
    @noko_doc.xpath('//p[@class="advisor-website"]/a/@href').first.value
  end
end

# BASIC RUNNER/TASK LOGIC:
# First, grab all the advisors

response = RestClient.post 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php', {action: 'do_ajax_advisor_search', page: '1', amountPerPage: '10', filterCriteria: 'fee-structure', filterValue: 'all' }

parsed_page = PageParser.new(response.body)

all_XYPN_advisor_urls = parsed_page.parse_advisor_list

# Next, iterate over each page to grab whatever info needed
# Just doing the first three of the array to not go crazy with the requests

advisor_urls = []

all_XYPN_advisor_urls[0..2].each do | xypn_url |
  response = RestClient.get(xypn_url)
  parsed_page = PageParser.new(response.body)
  advisor_urls << { "#{xypn_url}" => parsed_page.parse_advisor_page }
end

puts advisor_urls

