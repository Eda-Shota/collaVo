class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def freeze
    @user = USer.find(params[:id])
    @user = User.update(freeze: true)
    redirect_to admin_users_index_path
  end
  def unfreeze
    @user = USer.find(params[:id])
    @user = User.update(freeze: false)
    redirect_to admin_users_index_path
  end
end
