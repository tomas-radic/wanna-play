class AddNoteToAvailabilities < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :note, :string
  end
end
