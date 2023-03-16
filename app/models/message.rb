class Message < ApplicationRecord
  belongs_to :user
  belongs_to :dmroom
  
  with_options presence: true do
    validates :message
    validates :user_id
    validates :dmroom_id
  end
  
end
