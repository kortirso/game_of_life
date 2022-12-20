# frozen_string_literal: true

module Evolutionable
  extend ActiveSupport::Concern

  CONSTANTS = {
    Game::CLASSIC => { birth: [3], survival: [2, 3] },
    Game::DAY_NIGHT => { birth: [3, 6, 7, 8], survival: [3, 4, 6, 7, 8] },
    Game::NO_DEATH => { birth: [3], survival: [0, 1, 2, 3, 4, 5, 6, 7, 8] },
    Game::HIGH_LIFE => { birth: [3, 6], survival: [2, 3] },
    Game::SEEDS => { birth: [2], survival: [] }
  }.freeze
end
