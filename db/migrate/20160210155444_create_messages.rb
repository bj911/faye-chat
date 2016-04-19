class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.string :user_id
      t.string :chat_id

      t.timestamps null: false
    end
  end
end
