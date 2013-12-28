class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :twitter_username
      t.string :token
      t.string :secret
      t.string :twitteruid
      t.integer :user_id

      t.timestamps
    end
  end
end
