class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.text :phrase
      t.integer :alert_id

      t.timestamps
    end
  end
end
