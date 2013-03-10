class DomainsController < ApplicationController
  
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
    @domains = Domain.all
    render json: @domains
  end
  
  def new
    @domain = Domain.new
  end
  
  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      render json: @domain
      redirect_to "/admin"
    end
  end
end
