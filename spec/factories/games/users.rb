# frozen_string_literal: true

FactoryBot.define do
  factory :games_user, class: 'Games::User' do
    association :game
    association :user
  end
end
