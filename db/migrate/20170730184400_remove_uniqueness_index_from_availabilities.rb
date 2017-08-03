class RemoveUniquenessIndexFromAvailabilities < ActiveRecord::Migration[5.0]
  def change
  	remove_index(:availabilities, name: 'index_availabilities_on_user_id_and_date_and_period')
  end
end
