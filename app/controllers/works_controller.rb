class WorksController < ApplicationController
  
  def index
    @works = Work.all
    respond_to do |format|
      format.html
      format.json { render json: @works.as_json }
    end
  end
  
  def new
    @work = Work.new
    @types = Type.all
    @domains = Domain.all
    @time_periods = TimePeriod.all
  end
  
  def create
    @work = Work.new(params[:work])
    respond_to do |format|
      if @work.save
        format.html { redirect_to "/admin" }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def edit
    @work = Work.find(params[:id])
  end
  
  def update
    @work = Work.find(params[:work])
    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html { redirect_to "/admin" }
      else
        format.html { render action: 'update' }
      end
    end
  end
      
end
