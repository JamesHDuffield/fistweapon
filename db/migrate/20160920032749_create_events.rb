class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.string :character
      t.timestamp :when
      t.string :title
      t.string :description
      t.integer :itemId
      t.integer :achievementId

      t.timestamps
    end
  end
end
