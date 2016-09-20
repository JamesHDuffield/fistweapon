class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :spec
      t.integer :class
      t.string :name
      t.integer :race
      t.integer :gender
      t.integer :level
      t.integer :rank

      t.timestamps
    end
  end
end
