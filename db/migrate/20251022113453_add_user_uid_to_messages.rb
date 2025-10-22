class AddUserUidToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :user_uid, :string
  end
end
