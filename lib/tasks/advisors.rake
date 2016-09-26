require "xypn_seo/xypn_scraper/find_or_create_advisor_website"
require "xypn_seo/seo_evaluation/advisor_site_evaluation"

namespace :advisors do

  desc "Update list of XYPN advisors"
  task scrape: :environment do

    puts "This will take a few minutes."
    XYPNSEO::XYPNScraper::FindOrCreateAdvisorWebsite.new.call
    puts "#{Website.all.count} advisor websites saved to the database."

  end

  desc "Run PageSpeed Insights on advisor websites"
  task evaluate: :environment do

    puts "This will take upwards of 15 minutes."
    XYPNSEO::SEOEvaluation::AdvisorSiteEvaluation.new.call
    puts "All websites have been evaluated."

  end

end
