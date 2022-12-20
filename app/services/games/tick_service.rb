# frozen_string_literal: true

module Games
  class TickService
    prepend ApplicationService

    def initialize(moore_neighborhood_service: Games::MooreNeighborhoodService.new)
      @moore_neighborhood_service = moore_neighborhood_service
    end

    def call(game:)
      @game = game
      set_initial_values
      ActiveRecord::Base.transaction do
        update_game_tick
        check_cells
        find_cells_for_birth
        find_survival_cells
        update_cells
      end
    rescue ::ActiveRecord::StaleObjectError => _e
      Games::TickService.call(game: @game)
    end

    private

    def set_initial_values
      @evolution = Evolutionable::CONSTANTS[@game.evolution_type]
      @birth_cells_data = {}
      @survival_cells_data = {}
      @cells_for_update = []
    end

    def update_game_tick
      @game.update!(current_tick: @game.current_tick + 1)
    end

    def check_cells
      cells.with_life.each do |cell|
        @moore_neighborhood_service.call(column: cell.q, row: cell.r).result.each do |checking_cell|
          refresh_cell_data(cell, checking_cell[0], checking_cell[1])
        end
      end
    end

    def refresh_cell_data(current_cell, column, row)
      life_cell = current_life_cells_status.dig(column, row)
      if life_cell.nil?
        @birth_cells_data.deep_merge!(
          {
            column => {
              row => {
                current_cell.games_user_id => @birth_cells_data.dig(column, row, current_cell.games_user_id).to_i + 1
              }
            }
          }
        )
      else
        @survival_cells_data.deep_merge!({ column => { row => @survival_cells_data.dig(column, row).to_i + 1 } })
      end
    end

    def find_cells_for_birth
      @birth_cells_data.each do |q, values|
        values.each do |r, value|
          next unless @evolution[:birth].include?(value.values.sum)

          user_id = value.max_by { |_key, value| value }[0]
          add_cell_for_update(q, r, user_id)
        end
      end
    end

    def find_survival_cells
      @survival_cells_data.each do |q, values|
        values.each do |r, value|
          next if @evolution[:survival].include?(value)

          add_cell_for_update(q, r, nil)
        end
      end
    end

    def add_cell_for_update(column, row, user_id)
      cell = cells.find_by(q: column, r: row)
      @cells_for_update.push({
        uuid: cell.uuid,
        id: cell.id,
        game_id: cell.game_id,
        games_user_id: user_id
      })
    end

    def update_cells
      Cell.upsert_all(@cells_for_update) if @cells_for_update.any?
    end

    def cells
      @cells ||= @game.cells
    end

    # current status of cells before changes
    def current_life_cells_status
      @current_life_cells_status ||= cells.with_life.inject({}) do |acc, cell|
        acc.deep_merge({ cell.q => { cell.r => cell.games_user_id } })
      end
    end
  end
end
