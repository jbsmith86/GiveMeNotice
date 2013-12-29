class AddFeedNumberToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :feed_number, :integer
  end
end
