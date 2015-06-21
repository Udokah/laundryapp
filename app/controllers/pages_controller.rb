class PagesController < ApplicationController

  require 'Slack'

  @@slack = Slack.new

  def state_cookie
    require 'securerandom'
    if not cookies[:state] then
      random = SecureRandom.hex(10)
      cookies[:state] = { :value => random, :expires => 2.minutes.from_now }
    end
    return cookies[:state]
  end

  def authenticate_user
    if session[:user] == nil then
      redirect_to '/'
    end
  end

  def index 
    @page_title = "LaundryAlert"
    @class = "index"
    @auth_status = 'false'

    if session[:user] then
      redirect_to '/dashboard'
    end

    if params.has_key?(:code) && params.has_key?(:state) && cookies[:state] == params[:state]
      get_token = @@slack.get_token(params[:code]) # get access token
      if get_token["ok"] then
        auth_user = @@slack.auth_user(get_token["access_token"]) # authenticate user
        if auth_user["ok"] then
          # get users info now
          user_info = @@slack.get_user_info( get_token["access_token"], auth_user["user_id"] )
          if user_info["ok"] then
            session[:user] = { :info  => user_info["user"], 
                               :token => get_token["access_token"], 
                               :team  => auth_user["team_id"] }
            @auth_status = 'true'
            redirect_to '/dashboard'
          end
        end
      end
      @authorization_href = "Javascript:void()"
    else
      @auth_status = 'true'
      @authorization_href = @@slack.get_auth_href(state_cookie)
    end
  end

  def dashboard
    authenticate_user
    @page_title = "Dashboard"
    @class = "dashboard"
    @user = session[:user]
  end

  def schedule
    authenticate_user
    @page_title = "My Schedule"
    @class = "schedule"
    @user = session[:user]  
  end

  def logout
    if session[:user] then
      session.delete(:user)
    end
    redirect_to '/'
  end

end
