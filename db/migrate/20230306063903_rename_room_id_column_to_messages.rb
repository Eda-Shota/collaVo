class RenameRoomIdColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :room_id, :dmroom_id
  end
end
