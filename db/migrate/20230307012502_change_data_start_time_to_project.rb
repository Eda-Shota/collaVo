class ChangeDataStartTimeToProject < ActiveRecord::Migration[6.1]
  def change
  change_column :projects, :start_time, :text
  end
end
