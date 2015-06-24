class SchedulesController < ApplicationController
  protect_from_forgery

  def create
    @schedule = Schedule.new
    @schedule.slack_id = params[:id]
    @schedule.name = params[:name]
    @schedule.picture = params[:picture]
    @schedule.slack_token = params[:token]
    @schedule.email = params[:email]
    @schedule.status = "pending"

    if @schedule.save
      result = {:status => true}
    else
      result = {:status => false}
    end
    render json: @schedule
  end
  
end