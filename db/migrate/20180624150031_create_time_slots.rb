class CreateTimeSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :time_slots do |t|
      t.integer :order_key,         null: false
      t.string :label_begin_time,   null: false
      t.string :label_end_time,     null: false

      t.timestamps
    end
  end
end
