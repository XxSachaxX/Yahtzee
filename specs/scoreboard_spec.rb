require_relative '../models/scoreboard'

describe Scoreboard do
  it 'can be displayed in an ordered manner' do
    scoreboard = Scoreboard.new

    expect(scoreboard.show).to eq("ones: empty\ntwos: empty\nthrees: empty\nfours: empty\nfives: empty\nsixes: empty\npair: empty\ntwo pairs: empty\nthree of a kind: empty\nfour of a kind: empty\nsmall straight: empty\nlarge straight: empty\nfull house: empty\nyahtzee: empty\nchance: empty\n")
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
    context 'if the category exists' do
      context 'if points have already been written down for this category' do
        it 'should not write it down' do
          scoreboard = Scoreboard.new
          scoreboard.write(:ones, 2)

          expect { (scoreboard.write(:ones, 2)) }.to raise_error(Scoreboard::AlreadyWrittenForCategoryError)
        end
      end

      context 'if no points have been written down for this category' do
        it 'should write it down' do
          scoreboard = Scoreboard.new
          scoreboard.write(:ones, 2)

          expect(scoreboard.categories[:ones]).to eq(2)
        end
      end
    end

    context 'if the category does not exist' do
      it 'raises an error' do
        scoreboard = Scoreboard.new
        expect { scoreboard.write(:umpalumpa, 2) }.to raise_error(Scoreboard::CategoryDoesNotExistError)
      end
    end
  end
end