require 'nokogiri'
require_relative './html_cleaner'

module AdvisorPage

  def self.parse(html_string, xypn_url)
    create_nokogiri_doc(html_string)
    { 
      name:         parse_advisor_name,
      business:     parse_business_name,
      url:          parse_business_site,
      xypn_profile: xypn_url
    }
  end

  private

  attr_reader :noko_doc

  def self.create_nokogiri_doc(html_string)
    clean_html = HTMLCleaner.clean(html_string)
    @noko_doc = Nokogiri::HTML(clean_html)
  end

  def self.parse_advisor_name
    @noko_doc.xpath('//h1').children.first.text.strip
  end

  def self.parse_business_name
    @noko_doc.xpath('//h1').children.last.text
  end

  def self.parse_business_site
    if @noko_doc.xpath('//p[@class="advisor-website"]/a/@href').first.nil?
      "UNKNOWN"
    else
      @noko_doc.xpath('//p[@class="advisor-website"]/a/@href').first.value
    end
  end
end