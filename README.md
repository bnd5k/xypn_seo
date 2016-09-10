# README

This Rails app evaluates the financial advisors listed at [http://www.xyplanningnetwork.com/consumer/find-advisor/](http://www.xyplanningnetwork.com/consumer/find-advisor/). 


## Dealing with that pesky all-advisor AJAX call before running the scrape

Two approaches I can think of:

1) *Catching the AJAX call/JSON response*
* The call to load advisor content is a POST request to 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php' using the js file `/wp-content/plugins/ajax-advisor-search/assets/js/ajax-advisor-search.js?ver=1.0`
* The Rails open-uri module cannot make POST calls, therefore grabbing the XHR/JSON response might be difficult
* Still might be able to figure out this way if we can make/stub that call and get the response with just financial advisor
  - `rest-open-uri` gem can make POST requests?

2) **Current implementation (a bit of a pain)** *Use a webdriver to actually fire up a browser and wait for AJAX*

* Using Watir::Browser.new to open the advisor webpage and wait for AJAX calls.
* Watir uses Selenium WebDriver to open an actual Firefox browser widow, however the latest version of Firefox (48) has refused to sign the selenium extension. You need to download a different Firefox version - Watir suggests [45.0esr](https://ftp.mozilla.org/pub/firefox/releases/45.0esr/mac/ar/) as it works best with the newest Watir versions.
* Watir then has methods that will wait until DOM elements are present, then we fire up Nokogiri.
```ruby
if (browser.p(:class => 'advisor_city_state').when_present.present?) == true 
  # run the scrape
end
```

