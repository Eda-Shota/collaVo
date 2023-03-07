class ChangeDataStartTimeToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :start_time_detail, :text
    change_column :projects, :start_time, :datetime
  end
end
