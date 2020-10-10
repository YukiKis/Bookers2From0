class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :message, presence: true, length: { in: 1..100 }
end
