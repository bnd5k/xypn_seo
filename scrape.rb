require 'rest-client'


module HTMLCleaner
  def self.clean(html_string)
    clean_string = remove_any_white_space_between_tags(condense_whitespace(html_string)).strip
    remove_escape_characters(clean_string)
  end

  private

  def self.remove_any_white_space_between_tags(html_string)
    html_string.gsub(/(?<=>)\s+(?=<)/, "")
  end

  def self.condense_whitespace(html_string)
    html_string.gsub(/\s+/, ' ')
  end

  def self.remove_escape_characters(html_string)
    html_string.gsub(/\\/, '')
  end
end

response = RestClient.post 'http://www.xyplanningnetwork.com/wp-admin/admin-ajax.php', {action: 'do_ajax_advisor_search', page: '1', amountPerPage: '10', filterCriteria: 'fee-structure', filterValue: 'all' }

puts pure_html = HTMLCleaner.clean(response.body)
