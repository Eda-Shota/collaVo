class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates_uniqueness_of :project_id, scope: :user_id
 
  with_options presence: true do
    validates :user_id
    validates :project_id
  end

end
