require 'rest-client'
require '/xypn_seo/xypn_scraper/advisor_list'
require '/xypn_seo/xypn_scraper/advisor_page'
require '/xypn_seo/seo_evaluation/evaluation'

class FindOrCreateXYPNAdvisors

  def call
    response = RestClient.post xypn_url, form_fields
    parse_advisors(response.body)
  end

  private

  def xpyn_url
    'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php'
  end

  def form_fields
    {
      action: 'do_ajax_advisor_search', 
      filterCriteria: 'fee-structure', 
      filterValue: 'all' 
    } 
  end

  def parse_advisors(html_string)
    advisor_url_array = AdvisorList.parse(html_string)
    all_advisors = parse_individual_advisor_pages(advisor_url_array)
    persist_advisors(all_advisors)
  end

  def parse_individual_advisor_pages(url_array)
    url_array.map do |xypn_url|
      response = RestClient.get(xypn_url)
      advisor_info_hash = AdvisorPage.parse(response.body, xypn_url)
      advisor_info_hash
    end
  end

  def persist_advisors(advisors)
    advisors.each do |advisor|
      website = Website.find_or_initialize_by(xypn_profile: advisor[:xypn_profile])
      website.url = advisor[:url]
      website.business = advisor[:business]
      website.advisor = advisor[:name]
      website.save!
    end
  end
  
end
