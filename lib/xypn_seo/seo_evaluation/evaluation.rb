require 'rest-client'
require 'json'

class SiteEval

  def call
    evaluate_all_websites
  end

  private

  def evaluate_all_websites
    Website.all.each do | website |
      puts "Evaluating #{website.url}"
      website[:desktop_score] = overall_score(website.url, "desktop")
      website[:mobile_score] = overall_score(website.url, "mobile")
      website.save!
    end
  end

  def overall_score(url, strategy)
    begin
      url = "https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=#{url}&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false&strategy=#{strategy}"
      response = RestClient.get url
    rescue RestClient::BadRequest
      0
    else
      parsed = JSON.parse(response.body)
      parsed['score']
    end
  end

end
