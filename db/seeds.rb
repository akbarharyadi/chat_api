# This file ensures baseline data for any environment. Rerunning seeds should
# leave the data consistent, so keep inserts idempotent.

general = Chatroom.find_or_create_by!(name: "General")

[
  { user_uid: "system", user_name: "System", body: "Welcome to the General chatroom!" },
  { user_uid: "alice-uuid", user_name: "Alice", body: "Hi there, excited to test Action Cable." },
  { user_uid: "bob-uuid", user_name: "Bob", body: "Same here-messaging looks good already." }
].each do |attrs|
  general.messages.find_or_create_by!(attrs)
end
