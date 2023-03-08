class ChangeProjectcommentsToProjectComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :projectcomments, :project_comments
  end
end
