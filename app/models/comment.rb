class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :comment, presence: true , length: { in: 5..200 }
end
