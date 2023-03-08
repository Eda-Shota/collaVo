class Project < ApplicationRecord
  belongs_to :user
  
  with_options dependent: :destroy do
    has_many :project_comments
    has_many :favorites
    has_many :join_projects
  end
  
  has_one_attached :project_image
  
  with_options presence: true do
    validates :user_id
    validates :title
    validates :status
  end
  
  enum status: { draft: 0, recruiting: 1, stopped: 2, ended: 3}
  
  def remaining_number
    capacity-join_projects.count
  end
end
