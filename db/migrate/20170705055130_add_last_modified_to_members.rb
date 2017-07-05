class AddLastModifiedToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :last_modified, :datetime
  end
end
