require 'nokogiri'
require 'xypn_seo/xypn_scraper/html_cleaner'

module XYPNSEO
  module XYPNScraper
    class ScrapeAdvisorProfilePage
      def parse(html_string, xypn_url)
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

      def create_nokogiri_object(html_string)
        clean_html = HTMLCleaner.clean(html_string)
        @nokogiri_object = Nokogiri::HTML(clean_html)
      end

      def parse_advisor_name
        @nokogiri_object.xpath('//h1').children.first.text.strip
      end

      def parse_business_name
        @nokogiri_object.xpath('//h1').children.last.text
      end

      def parse_business_site
        @nokogiri_object.xpath('//ul//li//a[@target="_blank"]').first.text
      rescue NoMethodError => e # xpath value is nil if no website exists
        Rails.logger.error(e)
        return # returns nil, DB is unaffected
      end
    end
  end
end
