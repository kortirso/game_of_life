# frozen_string_literal: true

class Game < ApplicationRecord
  include Uuidable

  SQUARE = 'square'
  HEXAGON = 'hexagon'
  CLASSIC = 'classic'
  DAY_NIGHT = 'day_night'
  NO_DEATH = 'no_death'
  HIGH_LIFE = 'high_life'
  SEEDS = 'seeds'

  has_many :games_users, class_name: '::Games::User', dependent: :destroy
  has_many :users, through: :games_users
  has_many :cells, dependent: :destroy

  enum cell_type: { SQUARE => 0, HEXAGON => 1 }
  enum evolution_type: { CLASSIC => 0, DAY_NIGHT => 1, NO_DEATH => 2, HIGH_LIFE => 3, SEEDS => 4 }
end
