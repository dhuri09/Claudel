class UsersController < ApplicationController
  def admin
    @works = Work.all
  end
end
