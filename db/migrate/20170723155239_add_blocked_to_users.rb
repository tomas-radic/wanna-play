class AddBlockedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :blocked, :boolean, null: false, default: false
  end
end
