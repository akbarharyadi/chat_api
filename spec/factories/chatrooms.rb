FactoryBot.define do
  factory :chatroom do
    sequence(:name) { |n| "Chatroom #{n}" }
  end
end
