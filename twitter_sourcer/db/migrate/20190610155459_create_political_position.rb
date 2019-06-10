class CreatePoliticalPosition < ActiveRecord::Migration[5.2]
  def change
    create_table :political_positions do |t|
      t.string :twitter_id, null: false
      t.string :screen_name, null: false
      t.boolean :is_climate_change_denier
      t.references :twitter_account, index: true

      t.timestamps
    end
  end
end
