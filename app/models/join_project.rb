class JoinProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates_uniqueness_of :project_id, scope: :user_id
  
  enum status: { applying: 0, permission: 1, disapproval: 2}
  
end
