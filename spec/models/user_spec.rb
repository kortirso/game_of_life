# frozen_string_literal: true

describe User do
  it 'factory should be valid' do
    user = build :user

    expect(user).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_one(:users_session).class_name('::Users::Session').dependent(:destroy) }
    it { is_expected.to have_many(:games_users).class_name('::Games::User').dependent(:destroy) }
    it { is_expected.to have_many(:games).through(:games_users) }
  end
end
