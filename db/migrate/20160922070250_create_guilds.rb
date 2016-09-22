class CreateGuilds < ActiveRecord::Migration[5.0]
  def change
    create_table :guilds do |t|
      t.string :name
      t.string :realm
      t.integer :level
      t.integer :side
      t.integer :achievement_points
      t.integer :icon
      t.string :icon_colour
      t.integer :icon_colour_id
      t.integer :border
      t.string :border_colour
      t.integer :border_colour_id
      t.string :background_colour
      t.integer :background_colour_id

      t.timestamps
    end
  end
end
