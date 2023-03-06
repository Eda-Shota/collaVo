class RenameRoomIdColumnToEntries < ActiveRecord::Migration[6.1]
  def change
    rename_column :entries, :room_id, :dmroom_id
  end
end
