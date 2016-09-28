class WebsitesController < ApplicationController
  def index
    @websites = case params['sort']
                when 'mobile_asc'
                  Website.mobile_asc
                when 'mobile_desc'
                  Website.mobile_desc
                when 'desktop_asc'
                  Website.desktop_asc
                when 'desktop_desc'
                  Website.desktop_desc
                else
                  Website.all
                end
  end
end
