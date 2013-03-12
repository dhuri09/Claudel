class UsersController < ApplicationController
  
  before_filter :require_login, :only => ["admin"]

  def require_login
    unless logged_in?
      redirect_to '/' # halts request cycle
    end
  end
 
  def logged_in?
    !!current_user
  end
  
  def admin
    @works = Work.all
  end
  
  def home
  end
  
end
