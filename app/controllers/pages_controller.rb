class PagesController < ApplicationController

  include Slack_module

  @@slack = Slack_module::Slack.new

  def set_state_cookie
    require 'securerandom'
    if not cookies[:state] then
      cookies[:state] = { :value => SecureRandom.hex(10), :expires => 2.minutes.from_now }
    end
  end

  def authenticate_user
    if session[:user] == nil then
      redirect_to '/'
    end
  end

  def index 
    @page_title = "LaundryAlert"
    @slack_response = nil
  end

  def dashboard
    authenticate_user
    @page_title = "Dashboard"
    @class = "dashboard"
  end

  def schedule
    authenticate_user
    @page_title = "My Schedule"
    @class = "schedule"
  end

end
