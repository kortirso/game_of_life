# frozen_string_literal: true

describe Games::TickService, type: :service do
  subject(:service_call) { described_class.call(game: game) }

  let!(:user) { create :user }
  let!(:game) { Games::GenerateService.call(params: { cell_type: Game::SQUARE, map_size: { q: 5, r: 5 } }).result }

  before do
    game.cells.where(q: 2, r: [2, 3, 4]).update_all(games_user_id: user.id)
  end

  it 'update game tick' do
    expect { service_call }.to change(game, :current_tick).by(1)
  end

  it 'update game cells', :aggregate_failures do
    service_call

    game.cells.where(q: [1, 2, 3], r: 3).each do |cell|
      expect(cell.games_user_id).not_to be_nil
    end
    game.cells.where(q: 2, r: [2, 4]).each do |cell|
      expect(cell.games_user_id).to be_nil
    end
  end

  it 'succeeds' do
    expect(service_call.success?).to be_truthy
  end
end
