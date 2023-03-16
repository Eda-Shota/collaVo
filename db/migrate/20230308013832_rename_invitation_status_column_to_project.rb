class RenameInvitationStatusColumnToProject < ActiveRecord::Migration[6.1]
  def change
    rename_column :projects, :Invitation_status, :status
  end
end
