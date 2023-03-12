class RoomsController < ApplicationController
  def index
    @entries = current_user.entries.all
    @my_room_id = []
    @entries.each do |entry|
      @my_room_id << entry.dmroom.id
    end
    @another_entries = Entry.where(dmroom_id: @my_room_id).where.not(user_id: current_user.id)
  end

  def show
    @dmroom = Dmroom.find(params[:id])
    if Entry.where(user_id: current_user.id, dmroom_id: @dmroom.id).present?
      @messages = @dmroom.messages.includes(:user).order("created_at desc")
      @messages = @messages.page(params[:page]).per(10)
      @message = Message.new
      @entries = @dmroom.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @dmroom = Dmroom.create
    @joinCurrentUser = Entry.create!(user_id: current_user.id, dmroom_id: @dmroom.id)
    @joinUser = Entry.create(join_room_params)
    redirect_to room_path(@dmroom.id)
  end
  
  private
  def join_room_params
      params.require(:entry).permit(:user_id, :dmroom_id).merge(dmroom_id: @dmroom.id)
  end  
  
end
