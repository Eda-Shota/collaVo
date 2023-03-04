class Project < ApplicationRecord
  belongs_to :user
  has_many :project_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :join_projects, dependent: :destroy
  
  has_one_attached :project_image
  
  with_options presence: true do
    validates :user_id
    validates :title
    validates :Invitation_status
  end
  
end
