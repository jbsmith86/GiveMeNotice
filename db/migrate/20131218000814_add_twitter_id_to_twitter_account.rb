class AddTwitterIdToTwitterAccount < ActiveRecord::Migration
  def change
    add_column :twitter_accounts, :twitter_id, :integer
  end
end
