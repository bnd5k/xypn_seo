# README

This Rails app evaluates the financial advisors listed at [http://www.xyplanningnetwork.com/consumer/find-advisor/](http://www.xyplanningnetwork.com/consumer/find-advisor/). 

--- 

## In Progress

Next steps:
> * Finalize the API logic (getting what is needed from PageSpeed Insights)
> * Ask Ben for some guidance on smart/conventional architecture for the functionality of the app.

Pertinent notes:
>* An array of all current advisors (09/13/16) lives in /lib/advisors.rb
>* All current request, scraping, and evalution logic lives in /lib/scraper.rb.

---

## Data Extraction

This app first scrapes content from the HTML documents listing all XYPN advisors and their individual profile pages.  

The [page listing all advisors](http://www.xyplanningnetwork.com/consumer/find-advisor/) displays advisor content after making an AJAX POST request, which the app uses to collect each advisor's [XYPN profile page](http://www.xyplanningnetwork.com/advisors/paul-v-sydlansky-mba-cfp/) URL. The app then iterates over the list of individual profile URLs, making a request on each, and scraping data (notably their personal/business site).  

---

## Site Evalution

The app utilizes the Google PageSpeed Insights API to evaluate the overall performance individual advisor's business site. (It also goes so far as to offer suggestions for improvement, but the current scope of this app will not be taking advantage of that functionality?)  

API gets hit with `"https://www.googleapis.com/pagespeedonline/v1/runPagespeed?url=http://advisor_site_url/&key=#{ENV['PAGESPEED_KEY']}"` (note the variable params for 'url' and 'key'). Scores are scraped and persisted to the database.  

---

## Local Configuration

In order for the API to work in development, you must [generate a Google API key](https://console.developers.google.com/apis/credentials?project=xypn-scraper). This app utilizes the 'dotenv-rails' gem to store key securely on your local environment. It requires that you create a `.env` file in the root of the app, and store the key as `PAGESPEED_KEY=<yourkeyhere>`.

---


