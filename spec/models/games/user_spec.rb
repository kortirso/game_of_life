# frozen_string_literal: true

describe Games::User do
  it 'factory should be valid' do
    games_user = build :games_user

    expect(games_user).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:user) }
  end
end
