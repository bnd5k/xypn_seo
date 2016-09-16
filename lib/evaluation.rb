require 'rest-client'

p ENV["PAGESPEED_KEY"]

# response = RestClient.get "https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=http://AttainableWealthFP.com/&key=#{ENV['PAGESPEED_KEY']}"

# puts response