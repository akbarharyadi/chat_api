# This file ensures baseline data for any environment. Rerunning seeds should
# leave the data consistent, so keep inserts idempotent.

general = Chatroom.find_or_create_by!(name: "General")

[
  { user_uid: "system", user_name: "System", body: "Welcome to the General chatroom!" },
  { user_uid: "akbar-uuid", user_name: "Akbar", body: "Hi there, excited to test application." },
  { user_uid: "haryadi-uuid", user_name: "Haryadi", body: "Okay." }
].each do |attrs|
  general.messages.find_or_create_by!(attrs)
end
