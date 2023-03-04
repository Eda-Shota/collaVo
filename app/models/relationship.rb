class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates_uniqueness_of :followed_id, scope: :follower_id
  
  with_options presence: true do
    validates :follower_id
    validates :followed_id
  end
end
