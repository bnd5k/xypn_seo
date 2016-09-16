require 'rest-client'

response = RestClient.get "https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=http://AttainableWealthFP.com/&key=#{ENV['PAGESPEED_KEY']}&prettyprint=false"

response['score'] # overall score