class SchedulesController < ApplicationController
  protect_from_forgery

  def create
    @schedule = Schedule.new
    @schedule.fellow_uid = params[:user]
    @schedule.status = "pending"
    @schedule.save
    today = Schedule.where("created_at >= ? and fellow_uid = ?", Time.zone.now.beginning_of_day, params[:user])
    render json: today
  end
  
end