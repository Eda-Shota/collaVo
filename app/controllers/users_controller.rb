class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])  
    
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
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報の編集に成功しました"
    else
      render "edit"
    end
  end

  def index
    @users = User.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
  
end
