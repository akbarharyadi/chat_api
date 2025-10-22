require "rails_helper"

RSpec.describe ChatroomChannel, type: :channel do
  let(:chatroom) { create(:chatroom) }

  it "streams from the chatroom when a valid id is provided" do
    subscribe(chatroom_id: chatroom.id)
    expect(subscription).to be_confirmed
    expect(subscription.streams).to include(ChatroomChannel.broadcasting_for(chatroom))
  end

  it "rejects the subscription when the chatroom cannot be found" do
    subscribe(chatroom_id: "missing")

    expect(subscription).to be_rejected
  end
end
