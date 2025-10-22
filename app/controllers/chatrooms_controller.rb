class ChatroomsController < ApplicationController
  def index
    chatrooms = Chatroom.order(created_at: :asc)
    render json: chatrooms.map { ChatroomSerializer.new(_1).as_json }
  end

  def show
    chatroom = Chatroom.find(params[:id])
    render json: ChatroomSerializer.new(chatroom).as_json
  end

  def create
    chatroom = Chatroom.new(chatroom_params)

    if chatroom.save
      render json: ChatroomSerializer.new(chatroom).as_json, status: :created
    else
      render json: { errors: chatroom.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
