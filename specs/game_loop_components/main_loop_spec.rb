require_relative '../../game'
require_relative '../../game_loop_components/main_loop'

describe GameLoopComponents::MainLoop do
  it 'knows which game is ongoing' do
    game = Game.new(%w[John Paul])

    expect(GameLoopComponents::MainLoop.new(game).game).to eq(game)
  end
end