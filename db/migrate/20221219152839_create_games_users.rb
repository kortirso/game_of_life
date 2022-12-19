class CreateGamesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :games_users do |t|
      t.bigint :game_id
      t.bigint :user_id
      t.timestamps
    end
    add_index :games_users, [:game_id, :user_id], unique: true
  end
end
