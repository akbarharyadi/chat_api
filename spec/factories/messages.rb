FactoryBot.define do
  factory :message do
    body { "MyText" }
    user_name { "MyString" }
    chatroom { nil }
  end
end
