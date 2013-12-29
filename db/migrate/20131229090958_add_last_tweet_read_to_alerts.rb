class AddLastTweetReadToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :last_tweet_read, :integer
  end
end
