require 'rest-client'

module XYPNSEO
  module SEOEvaluation
    class AdvisorSiteEvaluation

      def call
        evaluate_all_websites
      end

      private

      def evaluate_all_websites
        Website.all.each do | website |
          desktop_api_call = craft_api_call(website.url, "desktop")
          mobile_api_call = craft_api_call(website.url, "mobile")
          website.desktop_score = obtain_score(desktop_api_call)
          website.mobile_score = obtain_score(mobile_api_call)
          website.save!
        end
      end

      def obtain_score(api_url)
        begin
          api_response = RestClient.get(api_url)
          response_as_json = JSON.parse(api_response.body)
          response_as_json['score']
        rescue RestClient::BadRequest => e
          Rails.logger.error(e)
          return 0 # Website score columns placeholder, required for correct scope querying
        rescue RestClient::InternalServerError => e
          Rails.logger.error(e)
          return 0 
        end
      end

      def craft_api_call(site_url, strategy)
        "https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=#{site_url}&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false&strategy=#{strategy}"
      end

    end
  end
end
