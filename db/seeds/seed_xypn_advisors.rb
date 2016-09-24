require 'rest-client'
require './lib/xypn_seo/xypn_scraper/advisor_list'
require './lib/xypn_seo/xypn_scraper/advisor_page'
require './lib/xypn_seo/seo_evaluation/evaluation'

class SeedXYPNAdvisors

  def call
    url = 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php'
    form_fields = {
                    action: 'do_ajax_advisor_search', 
                    page: '1', 
                    amountPerPage: '10', 
                    filterCriteria: 'fee-structure', 
                    filterValue: 'all' 
                  }
    response = RestClient.post url, form_fields
    parse_advisors(response.body)
  end

  private

  def parse_advisors(html_string)
    advisor_url_array = AdvisorList.parse(html_string)
    all_advisors = parse_individual_advisor_pages(advisor_url_array)
    seed_advisors(all_advisors)
  end

  def parse_individual_advisor_pages(url_array)
    url_array.map do | xypn_url |
      response = RestClient.get(xypn_url)
      advisor_info_hash = AdvisorPage.parse(response.body, xypn_url)
      puts "Successfully parsed: #{advisor_info_hash[:xypn_profile]}"
      advisor_info_hash
    end
  end

  def seed_advisors(advisor_hashes)
    advisor_hashes.each do | advisor_hash |
      website = Website.find_or_initialize_by(xypn_profile: advisor_hash[:xypn_profile])
      website[:url] = advisor_hash[:url]
      website[:business] = advisor_hash[:business]
      website[:advisor] = advisor_hash[:name]
      website.save!
    end
  end
  
end
