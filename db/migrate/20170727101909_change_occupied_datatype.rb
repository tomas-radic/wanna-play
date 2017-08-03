class ChangeOccupiedDatatype < ActiveRecord::Migration[5.0]
  def change
  	remove_column :availabilities, :occupied, :boolean
  	add_column :availabilities, :occupied_since, :datetime
  end
end
