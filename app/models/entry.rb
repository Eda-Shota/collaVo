class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :dmroom
  
  validates :room_id, uniqueness: { scope: :user_id }
  
  with_options presence: true do
    validates :user_id
    validates :room_id
  end
end
