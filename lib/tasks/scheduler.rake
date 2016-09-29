require 'xypn_seo/xypn_scraper/find_or_create_advisor_website'
require 'xypn_seo/seo_evaluation/advisor_site_evaluation'

namespace :advisors do
  desc 'Update list of XYPN advisors'
  task scrape_and_evaluate: :environment do
    XYPNSEO::XYPNScraper::FindOrCreateAdvisorWebsite.new.call

    # XYPNSEO::SEOEvaluation::AdvisorSiteEvaluation.new.call
  end
end
