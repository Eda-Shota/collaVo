class Contact < ApplicationRecord
  with_options presence: true do  
    validates :name
    validates :content
  end
end
