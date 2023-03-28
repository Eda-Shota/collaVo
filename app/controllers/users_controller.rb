class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :ensure_correct_user, :ensure_guest_user]
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @projects = Project.where(user_id: @user).new_order(params)
    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.dmroom_id == u.dmroom_id
              @haveRoom = true
              @roomId = cu.dmroom_id
            end
          end
        end
        unless @haveRoom
          @dmroom = Dmroom.new
          @entry = Entry.new
        end
      end
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報の編集に成功しました"
    else
      render "edit"
    end
  end

  def index
    @users = User.login_order(params)
    @pagenation = @users
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to user_path(current_user) unless @user.id == current_user.id
  end

end
