class RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.order("current_sign_in_at desc").page(params[:page]).per(10)
    render "users/index" 
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.order("current_sign_in_at desc").page(params[:page]).per(10)
    render "users/index" 
  end
  
end
