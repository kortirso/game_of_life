class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.integer :cell_type, null: false, default: 0
      t.integer :evolution_type, null: false, default: 0
      t.bigint :current_tick, null: false, default: 0
      t.timestamps
    end
  end
end
