class AddAutocancelToAvailabilities < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :autocancel, :boolean, null: false, default: false
  end
end
