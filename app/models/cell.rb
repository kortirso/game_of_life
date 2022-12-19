# frozen_string_literal: true

class Cell < ApplicationRecord
  include Uuidable

  belongs_to :game
  belongs_to :games_user, class_name: '::Games::User', optional: true
end
