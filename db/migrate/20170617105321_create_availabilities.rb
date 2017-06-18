class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.integer :user_id, 	null: false
      t.date 		:date, 			null: false
      t.integer :period, 		null: false
      t.boolean :occupied, 	null: false, default: false

      t.timestamps
    end

    add_index :availabilities, [:user_id, :date, :period], unique: true
  end
end
