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

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries, source: :room




  def follow (user)
    self.active_relationships.create(followed: user)
  end

  def unfollow(user)
    self.active_relationships.find_by(followed: user).destroy
  end

  def following?(user)
    self.active_relationships.find_by(followed: user).present?
  end

  def room_with?(user)
    self.rooms.each do |room|
      if room.users.include?(user)
        @room = room
      else
        @room = nil
      end
    end
    return @room
  end

end
