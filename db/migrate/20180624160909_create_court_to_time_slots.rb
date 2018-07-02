class CreateCourtToTimeSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :court_to_time_slots do |t|
      t.integer :court_id, null: false
      t.integer :time_slot_id, null: false
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end
  end
end
