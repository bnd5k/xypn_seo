require 'rest-client'

module SiteEval

  def ping_api(url)
    response = RestClient.get("https://www.googleapis.com/pagespeedonline/v1/runPagespeed
                              ?url=#{url}&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false")
  end

  def overall_score(pagespeed_response)
    pagespeed_response['score']
  end

end