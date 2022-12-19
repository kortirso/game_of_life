class CreateCells < ActiveRecord::Migration[7.0]
  def change
    create_table :cells do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.bigint :game_id, null: false, index: true
      t.bigint :games_user_id, index: true
      t.integer :q, null: false, default: 0
      t.integer :r, null: false, default: 0
      t.timestamps
    end
  end
end
