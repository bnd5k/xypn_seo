namespace :advisors do

  desc "Update list of XYPN advisors"
  task seed: :environment do

    SeedXYPNAdvisors.call

  end

  desc "Run PageSpeed Insights on advisor websites"
  task evaluate: :environment do

    
      
  end

end
