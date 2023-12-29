require_relative '../models/player'

describe Player do
  it 'has a name' do
    expect(Player.new('John').name).to eq('John')
  end

  context 'when created' do
    it 'has an empty scoreboard' do
      expect(Player.new('John').scoreboard.categories).to eq({
                                                    ones: nil,
                                                    twos: nil,
                                                    threes: nil,
                                                    fours: nil,
                                                    fives: nil,
                                                    sixes: nil,
                                                    pair: nil,
                                                    two_pairs: nil,
                                                    three_of_a_kind: nil,
                                                    four_of_a_kind: nil,
                                                    small_straight: nil,
                                                    large_straight: nil,
                                                    full_house: nil,
                                                    yahtzee: nil,
                                                    chance: nil
                                                  })
    end
  end
end