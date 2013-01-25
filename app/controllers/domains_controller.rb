class DomainsController < ApplicationController
  
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
