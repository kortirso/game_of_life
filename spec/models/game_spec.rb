# frozen_string_literal: true

describe Game do
  it 'factory should be valid' do
    game = build :game

    expect(game).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:games_users).class_name('::Games::User').dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:games_users) }
  end
end
