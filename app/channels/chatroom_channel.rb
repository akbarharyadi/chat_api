class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.find_by(id: params[:chatroom_id])
    reject && return unless chatroom

    stream_for(chatroom)
  end

  def unsubscribed; end
end
