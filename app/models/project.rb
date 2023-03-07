class Project < ApplicationRecord
  belongs_to :user
  
  with_options dependent: :destroy do
    has_many :projectcomments
    has_many :favorites
    has_many :join_projects
  end
  
  has_one_attached :project_image
  
  with_options presence: true do
    validates :user_id
    validates :title
    validates :Invitation_status
  end
  
  enum Invitation_status: { draft: 0, recruiting: 1, stopped: 2, ended: 3}
  
  def remaining_number
    capacity-join_projects.count
  end
end
