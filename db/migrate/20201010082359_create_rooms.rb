class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :entry_id
      t.integer :message_id

      t.timestamps
    end
  end
end
