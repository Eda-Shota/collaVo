class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :Invitation_status, null: false, default: 0
      t.text :introduction
      t.string :category
      t.datetime :start_time
      t.text :requirement
      t.integer :capacity
      t.datetime :deadline
      t.timestamps
    end
  end
end
