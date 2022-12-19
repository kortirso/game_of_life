# frozen_string_literal: true

module Games
  # service for generating game with cells
  class GenerateService
    prepend ApplicationService

    def call(params:)
      ActiveRecord::Base.transaction do
        game = create_game(params)
        generate_cells(game)
      end
    end

    private

    def create_game(params)
      Game.create!(params)
    end

    def generate_cells(game)
      cells = []
      (0..game.map_size['r']).each do |row|
        (0..game.map_size['q']).each do |column|
          cells.push({
            uuid: SecureRandom.uuid,
            game_id: game.id,
            q: column,
            r: row
          })
        end
      end
      Cell.upsert_all(cells) if cells.any?
    end
  end
end
