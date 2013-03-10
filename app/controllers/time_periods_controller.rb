class TimePeriodsController < ApplicationController
  
  before_filter :require_login

  def require_login
    unless logged_in?
      redirect_to '/home' # halts request cycle
    end
  end
 
  def logged_in?
    !!current_user
  end
  
  def index
    @time_periods = TimePeriod.all
    @time_periods = @time_periods.sort_by { |time| time.season }
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
