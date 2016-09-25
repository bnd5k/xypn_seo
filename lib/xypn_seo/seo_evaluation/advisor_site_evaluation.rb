require 'rest-client'

class AdvisorSiteEvaluation

  def call
    evaluate_all_websites
  end

  private

  def evaluate_all_websites
    Website.all.each do | website |
      website.desktop_score = overall_score(website.url, "desktop")
      website.mobile_score = overall_score(website.url, "mobile")
      website.save!
    end
  end

  def obtain_score(url, strategy)
    begin
      url = "https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=#{url}&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false&strategy=#{strategy}"
      api_response = RestClient.get url
    rescue RestClient::BadRequest => e
      Rails.logger.error(e)
      return 0 # Website score columns placeholder, required for correct scope querying
    else
      response_as_json = JSON.parse(api_response.body)
      response_as_json['score']
    end
  end

end
