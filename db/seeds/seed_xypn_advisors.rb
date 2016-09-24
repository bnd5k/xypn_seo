require 'rest-client'

class SeedXYPNAdvisors

  def self.call
    url = 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php'
    form_fields = {
                    action: 'do_ajax_advisor_search', 
                    page: '1', 
                    amountPerPage: '10', 
                    filterCriteria: 'fee-structure', 
                    filterValue: 'all' 
                  }
    response = RestClient.post url, form_fields
    seed_advisors(response.body)
  end

  private

  def seed_advisors(html_string)
    advisor_url_array = AdvisorList.parse(html_string)
    all_advisor_info = parse_individual_advisor_pages(advisor_url_array)
    all_advisor_info.each do | advisor_hash |
      website = Website.find_or_initialize_by!(advisor_hash[:xypn_profile])
      website[:url] = advisor_hash[:url]
      website[:business] = advisor_hash[:business]
      website[:advisor] = advisor_hash[:advisor]
      website.save!
    end
  end

  def parse_individual_advisor_pages(url_array)
    url_array.map do | xypn_url |
      response = RestClient.get(xypn_url)
      advisor_info_hash = AdvisorPage.parse(response.body, xypn_url)
    end
  end

end
