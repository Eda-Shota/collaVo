class JoinProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates_uniqueness_of :project_id, scope: :user_id
  
  with_options presence: true do
    validates :user_id
    validates :project_id
    validates :status
  end
  
  enum join_projects: { applying: 0, permission: 1, disapproval: 2}
  
end
