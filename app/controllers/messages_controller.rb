class MessagesController < ApplicationController
  def create
    chatroom = Chatroom.find(params[:chatroom_id])
    message = chatroom.messages.new(message_params)

    if message.save
      render json: MessageSerializer.new(message).as_json, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_name, :user_uid)
  end
end
