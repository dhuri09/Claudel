class DomainsController < ApplicationController
  
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
    @domains = Domain.all
    render json: @domains
  end
  
  def edit
    @domain = Domain.find(params[:id])
  end
  
  def update
    @domain = Domain.find(params[:id])
    respond_to do |format|
      if @domain.update_attributes(params[:domain])
        format.html { redirect_to "/admin/domains" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def admin
    @domains = Domain.all
  end
  
  def new
    @domain = Domain.new
  end
  
  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      redirect_to "/admin"
    end
  end
  
  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy
    redirect_to "/admin/domains"
  end
  
end
