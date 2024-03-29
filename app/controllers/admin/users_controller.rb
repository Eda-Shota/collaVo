class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
    @users = @users.login_order(params)
    @pagenation = @users
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
