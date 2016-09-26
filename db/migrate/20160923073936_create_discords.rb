class CreateDiscords < ActiveRecord::Migration[5.0]
  def change
    create_table :discords do |t|
      t.timestamp :discord_timestamp
      t.boolean :pinned
      t.string :content
      t.integer :message_id
      t.integer :channel_id
      t.string :author

      t.timestamps
    end
  end
end
