class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :twitter_account_id
      t.string :sms_number

      t.timestamps
    end
  end
end
