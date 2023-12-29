require_relative '../scoreboard'

describe Scoreboard do
  it 'can be displayed in an ordered manner' do
    scoreboard = Scoreboard.new

    expect(scoreboard.show).to eq("ones: 0\ntwos: 0\nthrees: 0\nfours: 0\nfives: 0\nsixes: 0\npair: 0\ntwo pairs: 0\nthree of a kind: 0\nfour of a kind: 0\nsmall straight: 0\nlarge straight: 0\nfull house: 0\nyahtzee: 0\nchance: 0\n")
  end

  context 'when created' do
    it 'should have nil set for every category' do
      expect(Scoreboard.new.categories).to eq({
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

  context 'when given a category and a score' do
    context 'if no points have been written down for this category' do
      it 'should write it down' do
        scoreboard = Scoreboard.new
        scoreboard.write(:ones, 2)

        expect(scoreboard.categories[:ones]).to eq(2)
      end
    end

    context 'if points have already been written down for this category' do
      it 'should not write it down' do
        scoreboard = Scoreboard.new
        scoreboard.write(:ones, 2)

        expect { (scoreboard.write(:ones, 2)) }.to raise_error(Scoreboard::AlreadyWrittenForCategoryError)
      end
    end
  end
end