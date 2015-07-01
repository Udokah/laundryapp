class SchedulesController < ApplicationController
  protect_from_forgery
  require 'pry'

  def create
    @schedule = Schedule.new
    @schedule.status = "pending"
    today = Schedule.where("created_at >= ? and status != ?", Time.zone.now.beginning_of_day, "done")

    if today.length == 0 then
      @schedule.status = "active"
    end
    
    @schedule.slack_id = params[:id]
    @schedule.name = params[:name]
    @schedule.picture = params[:picture]
    @schedule.slack_token = params[:token]
    @schedule.email = params[:email]
    if @schedule.save
      result = {:status => true}
    else
      result = {:status => false}
    end
    render json: @schedule
  end

  def cancel
  end
  
end