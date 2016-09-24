require 'nokogiri'

class AdvisorPage
  extend HTMLCleaner

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

  def create_nokogiri_doc(html_string)
    clean_html = HTMLCleaner.clean(html_string)
    @noko_doc = Nokogiri::HTML(clean_html)
  end

  def parse_advisor_name
    if @noko_doc.xpath('//h1').children.first.text.nil?
      "UNKNOWN"
    else
      @noko_doc.xpath('//h1').children.first.text.strip
    end
  end

  def parse_business_name
    if @noko_doc.xpath('//h1').children.last.text.nil?
      "UNKNOWN"
    else
      @noko_doc.xpath('//h1').children.last.text
    end
  end

  def parse_business_site
    if @noko_doc.xpath('//p[@class="advisor-website"]/a/@href').first.nil?
      "UNKNOWN"
    else
      @noko_doc.xpath('//p[@class="advisor-website"]/a/@href').first.value
    end
  end

end