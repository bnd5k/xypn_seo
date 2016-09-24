require 'nokogiri'

class AdvisorList
  extend HTMLCleaner

  def self.parse(html_string)
    scrape_profile_urls(html_string)
  end

  private

  def scrape_profile_urls
    noko_doc = create_nokogiri_doc(html_string)
    noko_doc.xpath('//h3/a/@href').map do | noko_element_advisor_url |
      noko_element_advisor_url.value
    end
  end

  def create_nokogiri_doc(html_string)
    clean_html = HTMLCleaner.clean(html_string)
    Nokogiri::HTML(clean_html)
  end

end

