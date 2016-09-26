class ChangeColumnDiscord < ActiveRecord::Migration[5.0]
  def change
    change_column :discords, :message_id, :bigint
    change_column :discords, :channel_id, :bigint
  end
end
