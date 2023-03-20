class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
    @users = @users.page(params[:page]).per(10)
    render "admin/users/index.html"
  end
  
  def freeze
    @user = User.find(params[:id]).update(freeze: true)
    redirect_to admin_users_index_path
  end
  
  def unfreeze
    @user = User.find(params[:id]).update(freeze: false)
    redirect_to admin_users_index_path
  end
  
end
