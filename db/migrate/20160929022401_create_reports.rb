class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.string :character
      t.timestamp :posted
      t.integer :dkp

      t.timestamps
    end
  end
end
