# README

This Rails app evaluates the financial advisors listed at [http://www.xyplanningnetwork.com/consumer/find-advisor/](http://www.xyplanningnetwork.com/consumer/find-advisor/). 


---

## Data Extraction

This app first scrapes content from the HTML documents listing all XYPN advisors and their individual profile pages.  

`$ bundle exec rake advisors:scrape`  

---

## Site Evalution

After scraping the advisors, the app utilizes the Google PageSpeed Insights API to evaluate the overall performance of each advisor's business site.

`$ bundle exec rake advisors:evaluate`  

---

## Local Configuration

This app utilizes the 'dotenv-rails' gem to store keys securely in your local environment. This requires you to create a `.env` file in the root of the app, and store your own Google PageSpeed Insights key as `PAGESPEED_KEY=<yourkeyhere>`.  

---


