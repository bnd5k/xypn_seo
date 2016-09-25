require "./db/seeds/seed_xypn_advisors"

namespace :advisors do

  desc "Update list of XYPN advisors"
  task scrape: :environment do

    FindOrCreateXYPNAdvisors.new.call
    puts "#{Website.all.count} advisor websites saved to the database."

  end

  desc "Run PageSpeed Insights on advisor websites"
  task evaluate: :environment do

    SiteEval.new.call

  end

end
