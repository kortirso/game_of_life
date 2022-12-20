class AddLockVersionToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :lock_version, :bigint, null: false, default: 0
  end
end
