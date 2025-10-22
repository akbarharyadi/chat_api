class Message < ApplicationRecord
  belongs_to :chatroom

  validates :body, :user_name, presence: true
end
