class ChatroomSerializer
  def initialize(chatroom)
    @chatroom = chatroom
  end

  def as_json(*)
    {
      id: chatroom.id,
      name: chatroom.name,
      created_at: chatroom.created_at.iso8601,
      updated_at: chatroom.updated_at.iso8601
    }
  end

  private

  attr_reader :chatroom
end
