class Message < ApplicationRecord
  belongs_to :user
  belongs_to :dmroom
  
  with_options presence: true do
    validates :message
    validates :user_id
    validates :room_id
  end
  
end
