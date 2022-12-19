# frozen_string_literal: true

describe Cell do
  it 'factory should be valid' do
    cell = build :cell

    expect(cell).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:games_user).class_name('::Games::User').optional }
  end
end
