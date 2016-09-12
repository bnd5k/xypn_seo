require 'rest-client'

response = RestClient.post 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php', {action: 'do_ajax_advisor_search', page: '1', amountPerPage: '10', filterCriteria: 'fee-structure', filterValue: 'all' }

module HTMLWhitespaceCleaner
  def self.clean(html_string)
    remove_all_white_space_between_tags(condense_whitespace(html_string)).strip
  end

  private

  WHITE_SPACE_BETWEEN_TAGS = /(?<=>)\s+(?=<)/

  def self.remove_all_white_space_between_tags(html_string)
    html_string.gsub(WHITE_SPACE_BETWEEN_TAGS, "")
  end

  def self.condense_whitespace(html_string)
    html_string.gsub(/\s+/, ' ')
  end
end
