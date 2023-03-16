class ProjectComment < ApplicationRecord
    belongs_to :user
    belongs_to :project
    
  with_options presence: true do
    validates :user_id
    validates :project_id
    validates :comment
  end
    
end
