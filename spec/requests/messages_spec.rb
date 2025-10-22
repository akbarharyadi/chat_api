require "rails_helper"

RSpec.describe "Messages API", type: :request do
  describe "POST /chatrooms/:chatroom_id/messages" do
    before { host! "localhost" }

    let(:chatroom) { create(:chatroom) }
    it "persists and returns a message payload" do
      payload = {
        message: {
          body: "Hello world",
          user_name: "Alice",
          user_uid: "alice-uid"
        }
      }

      before_count = Message.count

      post chatroom_messages_path(chatroom), params: payload, as: :json

      expect(response).to have_http_status(:created), "response body: #{response.body}"
      expect(Message.count).to eq(before_count + 1)

      json = JSON.parse(response.body)
      expect(json).to include(
        "chatroom_id" => chatroom.id,
        "body" => "Hello world",
        "user_name" => "Alice",
        "user_uid" => "alice-uid"
      )
      expect(json).to have_key("id")
      expect(json).to have_key("created_at")
    end

    it "broadcasts the payload to subscribers" do
      payload = {
        message: {
          body: "Hello via broadcast",
          user_name: "Bob",
          user_uid: "bob-uid"
        }
      }

      expect do
        post chatroom_messages_path(chatroom), params: payload, as: :json
      end.to have_broadcasted_to(chatroom).from_channel(ChatroomChannel).with(hash_including(payload[:message]))

      expect(response).to have_http_status(:created), "response body: #{response.body}"
    end

    it "returns validation errors for bad input" do
      payload = {
        message: {
          body: "",
          user_name: "Alice",
          user_uid: nil
        }
      }

      before_count = Message.count

      post chatroom_messages_path(chatroom), params: payload, as: :json

      expect(Message.count).to eq(before_count)
      expect(response).to have_http_status(:unprocessable_entity), "response body: #{response.body}"

      json = JSON.parse(response.body)
      expect(json["errors"]).to include("Body can't be blank", "User uid can't be blank")
    end
  end
end
