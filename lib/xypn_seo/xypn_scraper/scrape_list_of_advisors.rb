require 'nokogiri'
require 'xypn_seo/xypn_scraper/html_cleaner'

module XYPNSEO
  module XYPNScraper
    class ScrapeListOfAdvisors
      extend HTMLCleaner

      def parse(html_string)
        scrape_profile_urls(html_string)
      end

      private

      def scrape_profile_urls(html_string)
        nokogiri_object = create_nokogiri_object(html_string)
        nokogiri_object.xpath('//h3/a/@href').map(&:value)
      end

      def create_nokogiri_object(html_string)
        clean_html = HTMLCleaner.clean(html_string)
        Nokogiri::HTML(clean_html)
      end
    end
  end
end
