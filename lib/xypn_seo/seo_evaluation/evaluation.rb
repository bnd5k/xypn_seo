require 'rest-client'
require 'json'

module SiteEval

  def overall_score(url, strategy)
    response = RestClient.get("https://www.googleapis.com/pagespeedonline/v1/runPagespeed
                              ?url=#{url}&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false
                              &strategy=#{strategy}")
    parsed = JSON.parse(response.body)
    parsed['score']
  end

end
