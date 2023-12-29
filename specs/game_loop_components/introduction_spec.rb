require_relative '../../game_loop_components/introduction'

describe GameLoopComponents::Introduction do
  it 'displays the game introductory text' do
    expect(GameLoopComponents::Introduction.text).to eq("Hi, welcome to my Yahtzee game.\nFirst, please enter the number of players(2-10)")
  end
end