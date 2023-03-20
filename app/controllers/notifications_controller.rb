class NotificationsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_notification, only: [:show, :edit, :update,]
  
  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(notification_params)
      if @notification.save
        redirect_to notifications_path, notice: "お知らせを投稿しました！"
      else
        flash[:alert] = "お知らせの投稿に失敗しました"
      end
  end

  def edit
  end

  def update
    if @notification.update(notification_params)
      redirect_to notification_path(@notification), notice: "企画内容を変更しました"
    else
      flash[:alert] = "変更できませんでした"
    end
  end
  
  def show
  end
  
  def index
    @notifications = Notification.all
    @notifications = @notifications.page(params[:page]).per(10)
  end
  
  def destroy
    @notification.destroy
     redirect_to notifications_path 
  end
  
  private
    
  def notification_params
    params.require(:notification).permit(:title, :introduction)
  end
  
  def set_notification
    @notification = Notification.find(params[:id]) 
  end
  
end
