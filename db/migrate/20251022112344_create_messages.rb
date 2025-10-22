class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :user_name
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
