require "securerandom"

FactoryBot.define do
  factory :message do
    body { "MyText" }
    user_name { "MyString" }
    user_uid { SecureRandom.uuid }
    association :chatroom
  end
end
