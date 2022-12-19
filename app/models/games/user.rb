# frozen_string_literal: true

module Games
  class User < ApplicationRecord
    self.table_name = :games_users

    belongs_to :game
    belongs_to :user
  end
end
