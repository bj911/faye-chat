class CreateConnects < ActiveRecord::Migration
  def change
    create_table :connects do |t|
      t.integer :user_id
      t.integer :chat_id

      t.timestamps null: false
    end
  end
end
