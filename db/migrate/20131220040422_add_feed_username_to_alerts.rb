class AddFeedUsernameToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :feed_username, :string
  end
end
