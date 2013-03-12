class WorksController < ApplicationController
  
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
    @works = Work.all
    @time_periods = TimePeriod.all.sort_by { |time| time.season }
    @types = Type.all
    @domains = Domain.all
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
    @types = Type.all
    @domains = Domain.all
    @time_periods = TimePeriod.all
  end
  
  def update
    @work = Work.find(params[:id])
    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html { redirect_to "/admin" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def images
    @work = Work.find(params[:id])
    images = @work.images
    render json: images.as_json
  end
  
  def edit_images
    @work = Work.find(params[:id])
    @image = Image.new
  end
  
end
