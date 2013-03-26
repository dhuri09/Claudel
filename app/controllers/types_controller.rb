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
  
  def admin
    @types = Type.all
  end
  
  def edit
    @type = Type.find(params[:id])
  end
  
  def update
    @type = Type.find(params[:id])
    respond_to do |format|
      if @type.update_attributes(params[:type])
        format.html { redirect_to "/admin/types" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
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
  
  def destroy
    @type = Type.find(params[:id])
    @type.destroy
    redirect_to "/admin/types"
  end
end
