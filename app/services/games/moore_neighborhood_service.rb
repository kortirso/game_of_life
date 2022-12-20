# frozen_string_literal: true

module Games
  class MooreNeighborhoodService
    prepend ApplicationService

    def call(column:, row:)
      @result =
        [
          [column, row - 1],
          [column + 1, row - 1],
          [column + 1, row],
          [column + 1, row + 1],
          [column, row + 1],
          [column - 1, row + 1],
          [column - 1, row],
          [column - 1, row - 1]
        ]
    end
  end
end
