class AddColumnResponseToApiRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :api_requests, :response, :text
  end
end
