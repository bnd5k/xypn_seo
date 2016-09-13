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

class XYPNParser
  def initialize(html_string)
    @noko_doc = create_nokogiri_doc(html_string)
  end

  def parse_advisor_list
    parse_profile_urls
  end

  def parse_advisor
    parse_advisor_page
  end

  private

  attr_reader :noko_doc

  def create_nokogiri_doc(html_string)
    clean_html = HTMLCleaner.clean(html_string)
    Nokogiri::HTML(clean_html)
  end

  def parse_profile_urls
    @noko_doc.xpath('//h3/a/@href').map do | noko_el |
      noko_el.value
    end
  end

  def parse_advisor_page
    { 
      name: grab_advisor_name,
      business: grab_business_name,
      url: grab_business_site
    }
  end

  def grab_advisor_name
    if @noko_doc.xpath('//h1').children.first.text.nil?
      "UNKNOWN"
    else
      @noko_doc.xpath('//h1').children.first.text.strip
    end
  end

  def grab_business_name
    if @noko_doc.xpath('//h1').children.last.text.nil?
      "UNKNOWN"
    else
      @noko_doc.xpath('//h1').children.last.text
    end
  end

  def grab_business_site
    if @noko_doc.xpath('//p[@class="advisor-website"]/a/@href').first.nil?
      "UNKNOWN"
    else
      @noko_doc.xpath('//p[@class="advisor-website"]/a/@href').first.value
    end
  end
end

# BASIC RUNNER/TASK LOGIC:
# First, grab all the advisors

response = RestClient.post 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php', {action: 'do_ajax_advisor_search', page: '1', amountPerPage: '10', filterCriteria: 'fee-structure', filterValue: 'all' }

parsed_page = XYPNParser.new(response.body)

all_XYPN_advisor_urls = parsed_page.parse_advisor_list

# Next, iterate over each page to grab whatever info needed
# Just doing the first three of the array to not go crazy with the requests

advisors = []

all_XYPN_advisor_urls.each do | xypn_url |
  response = RestClient.get(xypn_url)
  parsed_page = XYPNParser.new(response.body)
  advisor = parsed_page.parse_advisor
  advisor[:xypn_profile] = xypn_url
  puts advisor
  advisors << advisor
end
