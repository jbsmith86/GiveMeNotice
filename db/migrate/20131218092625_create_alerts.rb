class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :name
      t.boolean :email_enabled
      t.boolean :sms_enabled

      t.timestamps
    end
  end
end
