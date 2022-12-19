class AddMapSizeToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :map_size, :jsonb, null: false, default: {}
  end
end
