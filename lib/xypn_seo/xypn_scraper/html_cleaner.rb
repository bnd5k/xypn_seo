module HTMLCleaner

  def self.clean(html_string)
    clean_string = remove_any_white_space_between_tags(condense_whitespace(html_string)).strip
  end

  private

  def self.remove_any_white_space_between_tags(html_string)
    html_string.gsub(/(?<=>)\s+(?=<)/, "")
  end

  def self.condense_whitespace(html_string)
    html_string.gsub(/\s+/, ' ')
  end
  
end