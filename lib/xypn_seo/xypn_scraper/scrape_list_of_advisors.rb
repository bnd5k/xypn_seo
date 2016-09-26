require 'nokogiri'
require 'xypn_seo/xypn_scraper/html_cleaner'

module XYPNSEO
  module XYPNScraper
    class ScrapeListOfAdvisors
      
      extend HTMLCleaner

      def self.parse(html_string)
        scrape_profile_urls(html_string)
      end

      private

      def self.scrape_profile_urls(html_string)
        nokogiri_object = create_nokogiri_object(html_string)
        nokogiri_object.xpath('//h3/a/@href').map do |noko_element_advisor_url|
          noko_element_advisor_url.value
        end
      end

      def self.create_nokogiri_object(html_string)
        clean_html = HTMLCleaner.clean(html_string)
        Nokogiri::HTML(clean_html)
      end

    end
  end
end