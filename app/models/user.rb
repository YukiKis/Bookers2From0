class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 2..20 }

  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :active_relationships, dependent: :destroy, foreign_key: :follower_id, class_name: "Relationship"
  has_many :following, through: :active_relationships, source: "followed"

  has_many :passive_relationships, dependent: :destroy, foreign_key: :followed_id, class_name: "Relationship"
  has_many :followers, through: :passive_relationships, source: "follower"

  def follow (user)
    self.active_relationships.create(followed: user)
  end

  def unfollow(user)
    self.active_relationships.find_by(followed: user).destroy
  end

  def following?(user)
    self.active_relationships.find_by(followed: user).present?
  end
end
