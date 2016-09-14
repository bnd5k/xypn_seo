# README

This Rails app evaluates the financial advisors listed at [http://www.xyplanningnetwork.com/consumer/find-advisor/](http://www.xyplanningnetwork.com/consumer/find-advisor/).

## Data Extraction

This app first scrapes content from the HTML documents listing all XYPN advisors and their individual profile pages.

The [page listing all advisors](http://www.xyplanningnetwork.com/consumer/find-advisor/) displays advisor content after making an AJAX POST request, which the app uses to collect each advisor's XYPN profile page URL ([example profile page](http://www.xyplanningnetwork.com/advisors/paul-v-sydlansky-mba-cfp/)). The app then iterates over the list of individual profile URLs, making a request on each, and scraping data (notably their personal/business site).

## Business Site Evalution



