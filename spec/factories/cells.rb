# frozen_string_literal: true

FactoryBot.define do
  factory :cell do
    q { 0 }
    r { 0 }
    association :game
  end
end
