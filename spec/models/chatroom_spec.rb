require "rails_helper"

RSpec.describe Chatroom, type: :model do
  subject(:chatroom) { build(:chatroom) }

  it "is valid with a unique name" do
    expect(chatroom).to be_valid
  end

  it "requires a name" do
    chatroom.name = nil

    expect(chatroom).not_to be_valid
    expect(chatroom.errors[:name]).to include("can't be blank")
  end

  it "enforces unique names" do
    existing = create(:chatroom)

    duplicate = build(:chatroom, name: existing.name)

    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:name]).to include("has already been taken")
  end

  it "destroys associated messages" do
    chatroom = create(:chatroom)
    create(:message, chatroom: chatroom)

    expect { chatroom.destroy }.to change(Message, :count).by(-1)
  end
end
