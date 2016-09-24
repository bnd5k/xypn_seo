require 'rest-client'
require 'json'

module SiteEval

  def self.overall_score(url, strategy)
    begin
      response = RestClient.get("https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=#{url}&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false&strategy=#{strategy}")
    rescue RestClient::BadRequest
      0
    else
      parsed = JSON.parse(response.body)
      parsed['score']
    end
  end

end

Website.all.each do | website |
  p website.url
  website.desktop_score = SiteEval.overall_score(website.url, "desktop")
  website.mobile_score = SiteEval.overall_score(website.url, "mobile")
  p website.desktop_score
  p website.mobile_score
  website.save!
end

load "./lib/xypn_seo/seo_evaluation/evaluation.rb"


