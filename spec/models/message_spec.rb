require "rails_helper"

RSpec.describe Message, type: :model do
  subject(:message) { build(:message) }

  it "is valid with required attributes" do
    expect(message).to be_valid
  end

  it "requires a body" do
    message.body = nil

    expect(message).not_to be_valid
    expect(message.errors[:body]).to include("can't be blank")
  end

  it "requires a user_name" do
    message.user_name = nil

    expect(message).not_to be_valid
    expect(message.errors[:user_name]).to include("can't be blank")
  end

  it "requires a user_uid" do
    message.user_uid = nil

    expect(message).not_to be_valid
    expect(message.errors[:user_uid]).to include("can't be blank")
  end

  describe "broadcasting" do
    it "broadcasts to the chatroom after creation" do
      chatroom = create(:chatroom)

      expect do
        create(:message, chatroom: chatroom, body: "Hello", user_name: "Alice", user_uid: "alice-uid")
      end.to have_broadcasted_to(chatroom).from_channel(ChatroomChannel).with(hash_including(body: "Hello", user_name: "Alice", user_uid: "alice-uid"))
    end
  end
end
