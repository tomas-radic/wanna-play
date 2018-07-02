class CreateCourts < ActiveRecord::Migration[5.0]
  def change
    create_table :courts do |t|
      t.string :name,         null: false
      t.boolean :enabled,  null: false, default: true

      t.timestamps
    end
  end
end
