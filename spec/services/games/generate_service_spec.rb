# frozen_string_literal: true

describe Games::GenerateService, type: :service do
  subject(:service_call) { described_class.call(params: params) }

  let(:params) { { cell_type: Game::SQUARE, map_size: { q: 20, r: 20 } } }

  it 'creates Game' do
    expect { service_call }.to change(Game, :count).by(1)
  end

  it 'creates cells' do
    expect { service_call }.to change(Cell, :count).by(441)
  end

  it 'succeeds' do
    expect(service_call.success?).to be_truthy
  end
end
