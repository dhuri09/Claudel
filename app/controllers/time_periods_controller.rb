class TimePeriodsController < ApplicationController
  
  def index
    @time_periods = TimePeriod.all
    render json: @time_periods
  end
  
  def new
    @time_period = TimePeriod.new
  end
  
  def create
    @time_period = TimePeriod.new(params[:time_period])
    if @time_period.save
      #render json: @time_period
      redirect_to "/admin"
    end
  end
  
end
