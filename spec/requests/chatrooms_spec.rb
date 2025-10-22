require "rails_helper"

RSpec.describe "Chatrooms API", type: :request do
  before { host! "localhost" }

  describe "GET /chatrooms" do
    it "returns all chatrooms" do
      initial_count = Chatroom.count
      create_list(:chatroom, 2)

      get chatrooms_path, as: :json

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(initial_count + 2)
      expect(json.first).to include("id", "name", "created_at", "updated_at")
    end
  end

  describe "GET /chatrooms/:id" do
    it "returns a chatroom payload" do
      chatroom = create(:chatroom)

      get chatroom_path(chatroom), as: :json

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to include(
        "id" => chatroom.id,
        "name" => chatroom.name
      )
    end
  end

  describe "POST /chatrooms" do
    it "creates a chatroom" do
      params = { chatroom: { name: "New Room" } }

      expect do
        post chatrooms_path, params:, as: :json
      end.to change(Chatroom, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json).to include("name" => "New Room")
    end

    it "returns validation errors when name missing" do
      expect do
        post chatrooms_path, params: { chatroom: { name: "" } }, as: :json
      end.not_to change(Chatroom, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to include("Name can't be blank")
    end

    it "returns validation errors when name taken" do
      existing = create(:chatroom)

      expect do
        post chatrooms_path, params: { chatroom: { name: existing.name } }, as: :json
      end.not_to change(Chatroom, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to include("Name has already been taken")
    end
  end
end
