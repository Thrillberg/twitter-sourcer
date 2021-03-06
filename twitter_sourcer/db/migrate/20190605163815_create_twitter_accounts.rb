class CreateTwitterAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :twitter_accounts do |t|
      t.string :twitter_id, null: false
      t.string :name, null: false
      t.string :screen_name, null: false
      t.integer :friends_count, null: false
      t.datetime :populated_at
      t.references :follower, index: true

      t.timestamps
    end
  end
end
