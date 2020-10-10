class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 200 }

  scope :by_user_whole, ->(search) { Book.joins(:user).where("users.name LIKE ?", "#{search}") }
  scope :by_user_headpart, ->(search) { Book.joins(:user).where("users.name LIKE ?", "#{search}%") }
  scope :by_user_tailpart, ->(search) { Book.joins(:user).where("users.name LIKE ?", "%#{search}") }
  scope :by_user_part, ->(search) { Book.joins(:user).where("users.name LIKE ?", "%#{search}%") }

  scope :by_title_whole, ->(search){ Book.where("title LIKE ?", "#{search}") }
  scope :by_title_headpart, ->(search){ Book.where("title LIKE ?", "#{search}%") }
  scope :by_title_tailpart, ->(search){ Book.where("title LIKE ?", "%#{search}") }
  scope :by_title_part, ->(search) { Book.where("title LIKE ?", "%#{search}%") }

  def favorited_by?(user)
    self.favorites.where(user: user).exists?
  end
end
