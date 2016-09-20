class AddColumnToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :icon, :string
  end
end
