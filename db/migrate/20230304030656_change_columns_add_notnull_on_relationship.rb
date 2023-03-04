class ChangeColumnsAddNotnullOnRelationship < ActiveRecord::Migration[6.1]
  def change
    change_column :relationships, :follower_id, :integer, null: false, foreign_key: true
    change_column :relationships, :followed_id, :integer, null: false, foreign_key: true
  end
end
