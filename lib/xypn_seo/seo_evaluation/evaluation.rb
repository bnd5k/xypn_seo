require 'rest-client'
require 'json'

module SiteEval

  def self.overall_score(url, strategy)
    response = RestClient.get("https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=#{url}&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false&strategy=#{strategy}")
    parsed = JSON.parse(response.body)
    parsed['score']
  end

end

Website.all.each.with_index do | website, index |
  if website.url != "UNKNOWN"
    website.desktop_score = SiteEval.overall_score(website.url, "desktop")
    website.mobile_score = SiteEval.overall_score(website.url, "mobile")
    website.save
    puts "Finished #{index} - website.business"
  end
end

# site = Website.find(6)
# site.desktop_score = SiteEval.overall_score(website.url, "desktop")
# site.mobile_score = SiteEval.overall_score(website.url, "mobile")
# site.save