class Message < ApplicationRecord
  belongs_to :chatroom

  validates :body, :user_name, :user_uid, presence: true

  after_create_commit :broadcast_to_chatroom

  private

  def broadcast_to_chatroom
    ChatroomChannel.broadcast_to(chatroom, MessageSerializer.new(self).as_json)
  end
end
