require_relative "../xypn_seo/xypn_scraper/find_or_create_advisor_website"
require_relative "../xypn_seo/seo_evaluation/advisor_site_evaluation"

namespace :advisors do

  desc "Update list of XYPN advisors"
  task scrape: :environment do

    puts "This will take a few minutes."
    FindOrCreateAdvisorWebsite.new.call
    puts "#{Website.all.count} advisor websites saved to the database."

  end

  desc "Run PageSpeed Insights on advisor websites"
  task evaluate: :environment do

    puts "This will take a few minutes."
    AdvisorSiteEvaluation.new.call
    puts "All websites have been evaluated."

  end

end
