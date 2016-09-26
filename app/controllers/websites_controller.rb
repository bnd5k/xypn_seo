class WebsitesController < ApplicationController

  def index
    case params['sort']
    when 'mobile_asc'
      @websites = Website.mobile_asc
    when 'mobile_desc'
      @websites = Website.mobile_desc
    when 'desktop_asc'
      @websites = Website.desktop_asc
    when 'desktop_desc'
      @websites = Website.desktop_desc
    else
      @websites = Website.all
    end
  end

end