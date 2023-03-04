class CreateJoinProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :join_projects do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :project_id, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
