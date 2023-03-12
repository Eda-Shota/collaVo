class MessagesController < ApplicationController
    before_action :set_room, only: [:create, :edit, :update, :destroy]

  def create
    Entry.where(user_id: current_user.id, dmroom_id: @dmroom.id)
    @message = Message.create(message_params)
      if @message.save
        @message = Message.new
      else
        flash[:alert] = "メッセージの送信に失敗しました"
      end
      gets_entries_all_messages
      render "messages/create.js"
  end

  private

  def gets_entries_all_messages
    @messages = @dmroom.messages.includes(:user).order("created_at desc")
    @messages = @messages.page(params[:page]).per(10)
    @entries = @dmroom.entries
  end
   
  def set_room
    @dmroom = Dmroom.find(params[:message][:dmroom_id])
  end

  def message_params
    params.require(:message).permit(:user_id, :message, :dmroom_id).merge(user_id: current_user.id)
  end
  
end
