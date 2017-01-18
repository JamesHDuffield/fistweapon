class DropApiRequestsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :api_requests
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
