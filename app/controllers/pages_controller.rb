class PagesController < ApplicationController

  def index 
    @page_title = "WashAlert"
  end

  def dashboard
    @page_title = "Dashboard"
    @class = "dashboard"
  end

  def schedule
    @page_title = "My Schedule"
    @class = "schedule"
  end

end
