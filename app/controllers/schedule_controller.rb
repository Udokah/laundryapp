class ScheduleController < ApplicationController
  protect_from_forgery

  def create
    @result = { :result => true }
    render json: @result
  end
  
end
