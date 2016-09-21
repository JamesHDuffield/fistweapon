class CreateCreateTableProgressions < ActiveRecord::Migration[5.0]
  def change
    create_table :progressions do |t|
      t.string :raid
      t.string :boss
      t.integer :boss_id
      t.integer :lfr_kills
      t.timestamp :lfr_timestamp
      t.integer :normal_kills
      t.timestamp :normal_timestamp
      t.integer :heroic_kills
      t.timestamp :heroic_timestamp
      t.integer :mythic_kills
      t.timestamp :mythic_timestamp

      t.timestamps
    end
  end
end
