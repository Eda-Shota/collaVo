class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :dmroom
  
  validates :dmroom_id, uniqueness: { scope: :user_id }

end
