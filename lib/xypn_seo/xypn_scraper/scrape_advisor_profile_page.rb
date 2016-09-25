require 'nokogiri'
require_relative 'html_cleaner'

module ScrapeAdvisorProfilePage

  def self.parse(html_string, xypn_url)
    create_nokogiri_object(html_string)
    { 
      name:         parse_advisor_name,
      business:     parse_business_name,
      url:          parse_business_site,
      xypn_profile: xypn_url
    }
  end

  private

  attr_reader :nokogiri_object

  def self.create_nokogiri_object(html_string)
    clean_html = HTMLCleaner.clean(html_string)
    @nokogiri_object = Nokogiri::HTML(clean_html)
  end

  def self.parse_advisor_name
    @nokogiri_object.xpath('//h1').children.first.text.strip
  end

  def self.parse_business_name
    @nokogiri_object.xpath('//h1').children.last.text
  end

  def self.parse_business_site
    if @nokogiri_object.xpath('//p[@class="advisor-website"]/a/@href').first.nil?
      "UNKNOWN"
    else
      @nokogiri_object.xpath('//p[@class="advisor-website"]/a/@href').first.value
    end
  end
  
end