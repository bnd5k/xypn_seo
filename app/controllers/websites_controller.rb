class WebsitesController < ApplicationController
  def index
    @websites = case params['sort']
                when 'mobile_desc'
                  Website.mobile_desc
                when 'desktop_asc'
                  Website.desktop_asc
                when 'desktop_desc'
                  Website.desktop_desc
                else
                  Website.mobile_desc
                end
  end
end
