class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  with_options dependent: :destroy do
    has_many :projects
    has_many :projectcomments
    has_many :favorites
    has_many :relationships, class_name: "Relationship", foreign_key: "follower_id"
    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id"
    has_many :followings, through: :relationships, source: :followed
    has_many :followers, through: :reverse_of_relationships, source: :follower
    has_many :messages
    has_many :entries
    has_many :rooms, through: :entries
  end
  
  has_one_attached :user_image

  with_options presence: true do
    validates :name
    validates :email
    validates :encrypted_password
  end
  
  def get_user_image
    (user_image.attached?) ? user_image : 'no_image.jpg'
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定　userモデルを参照する条件式に使う
  def following?(user)
    followings.include?(user)
  end

  def self.looks(word)
    @user = User.where("name LIKE?","%#{word}%")
  end

end
