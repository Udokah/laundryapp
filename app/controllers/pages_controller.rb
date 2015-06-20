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

  def history
    @page_title = "Laundry History"
    @class = "history"
  end

end
