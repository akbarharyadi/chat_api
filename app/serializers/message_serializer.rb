class MessageSerializer
  def initialize(message)
    @message = message
  end

  def as_json(*)
    {
      id: message.id,
      chatroom_id: message.chatroom_id,
      body: message.body,
      user_name: message.user_name,
      user_uid: message.user_uid,
      created_at: message.created_at.iso8601
    }
  end

  private

  attr_reader :message
end
