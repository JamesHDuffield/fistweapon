class AddColumnCharacterClassToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :character_class, :integer
  end
end
