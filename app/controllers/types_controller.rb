class TypesController < ApplicationController
  
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
    @types = Type.all
    render json: @types
  end
  
  def new
    @type = Type.new
  end
  
  def create
    @type = Type.new(params[:type])
    respond_to do |format|
      if @type.save
        format.html { redirect_to "/admin" }
      else
        format.html { render action: 'new' }
      end
    end
  end
end
