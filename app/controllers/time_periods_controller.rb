class TimePeriodsController < ApplicationController
  
  before_filter :require_login

  def require_login
    unless logged_in?
      redirect_to '/' # halts request cycle
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
  
  def admin
    @time_periods = TimePeriod.all
  end
  
  def edit
    @time_period = TimePeriod.find(params[:id])
  end
  
  def update
    @time_period = TimePeriod.find(params[:id])
    respond_to do |format|
      if @time_period.update_attributes(params[:time_period])
        format.html { redirect_to "/admin/time_periods" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_period.errors, status: :unprocessable_entity }
      end
    end
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
