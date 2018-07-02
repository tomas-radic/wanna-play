class CreateOccupations < ActiveRecord::Migration[5.0]
  def change
    create_table :occupations do |t|
      t.integer :user_id,         null: false
      t.date :date,               null: false
      t.integer :court_id,        null: false
      t.integer :time_slot_id,    null: false
      t.string :note

      t.timestamps
    end

    add_index :occupations, [:court_id, :date, :time_slot_id], unique: true
  end
end
