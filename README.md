# README

This Rails app regularly evaluates the website page speed of all financial advisors listed at [http://www.xyplanningnetwork.com/consumer/find-advisor/](http://www.xyplanningnetwork.com/consumer/find-advisor/). It first scrapes content from the HTML documents listing all XYPN advisors and their individual profile pages. After scraping the advisors, the app utilizes the Google PageSpeed Insights API to evaluate the overall performance of each advisor's business site.

You can view the deployment of this application [here](http://www.xypnseo.tech/).  

---

## Local Configuration

This app utilizes the 'dotenv-rails' gem to store keys securely in your local environment. This requires you to create a `.env` file in the root of the app, and store your own Google PageSpeed Insights key as `PAGESPEED_KEY=<yourkeyhere>`.  

Run `$ bundle exec rake advisors:scrape_and_evaluate` to persist each financial advisor's website information and speed scores to the database.

---
