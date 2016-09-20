class RenameMembersClassColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :members, :class, :character_class
  end
end
