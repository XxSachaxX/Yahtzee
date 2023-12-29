require_relative '../models/roll_scorer'
require_relative '../models/roll'

describe RollScorer do
  context 'when given a roll and a category' do
    context 'when the chosen category is a digits category(ones to sixes)' do
      it 'returns the sum of the category digits in the roll' do
        roll = Roll.new
        roll.dices = [1, 1, 2, 3, 4]

        expect(RollScorer.new(roll, :ones).compute_score).to eq(2)
      end
    end

    context 'when the chosen category is pair' do
      it 'returns the sum of the two highest matching dices' do
        roll = Roll.new
        roll.dices = [1, 1, 2, 2, 4]

        expect(RollScorer.new(roll, :pair).compute_score).to eq(4)
      end
    end

    context 'when the chosen category is two pairs' do
      context 'if there are two pairs in the roll' do
        it 'returns the sum of the digits contained in those two pairs' do
          roll = Roll.new
          roll.dices = [1, 1, 2, 2, 4]

          expect(RollScorer.new(roll, :two_pairs).compute_score).to eq(6)
        end
      end

      context 'if there aren\'t two pairs in the roll' do
        it 'returns 0' do
          roll = Roll.new
          roll.dices = [2, 2, 3, 5, 4]

          expect(RollScorer.new(roll, :two_pairs).compute_score).to eq(0)
        end
      end
    end

    context 'when the chosen category is three of a kind' do
      context 'when the roll contains three identical digits' do
        it 'returns the sum of those three digits' do
          roll = Roll.new
          roll.dices = [2, 2, 2, 5, 4]

          expect(RollScorer.new(roll, :three_of_a_kind).compute_score).to eq(6)
        end
      end

      context 'when the roll contains more than three identical digits' do
        it 'returns the sum of only three of those identical digits' do
          roll = Roll.new
          roll.dices = [2, 2, 2, 2, 4]

          expect(RollScorer.new(roll, :three_of_a_kind).compute_score).to eq(6)
        end
      end

      context 'when the roll does not contain three identical digits' do
        it 'returns 0' do
          roll = Roll.new
          roll.dices = [2, 2, 3, 5, 4]

          expect(RollScorer.new(roll, :three_of_a_kind).compute_score).to eq(0)
        end
      end
    end

    context 'when the chosen category is four of a kind' do
      context 'when the roll contains four identical digits' do
        it 'returns the sum of those four digits' do
          roll = Roll.new
          roll.dices = [2, 2, 2, 2, 4]

          expect(RollScorer.new(roll, :four_of_a_kind).compute_score).to eq(8)
        end
      end
    end

    context 'when the chosen category is small straight' do
      it 'returns 0 unless the roll is 1, 2, 3, 4, 5' do
        roll = Roll.new
        roll.dices = [2, 2, 2, 2, 4]

        expect(RollScorer.new(roll, :small_straight).compute_score).to eq(0)
      end

      it 'returns 20 if the roll is 1, 2, 3, 4, 5' do
        roll = Roll.new
        roll.dices = [1, 2, 3, 4, 5]

        expect(RollScorer.new(roll, :small_straight).compute_score).to eq(15)
      end
    end

    context 'when the chosen category is large straight' do
      it 'returns 0 unless the roll is  2, 3, 4, 5, 6' do
        roll = Roll.new
        roll.dices = [2, 2, 2, 2, 4]

        expect(RollScorer.new(roll, :small_straight).compute_score).to eq(0)
      end

      it 'returns 20 if the roll is 1, 2, 3, 4, 5' do
        roll = Roll.new
        roll.dices = [2, 3, 4, 5, 6]

        expect(RollScorer.new(roll, :large_straight).compute_score).to eq(20)
      end
    end

    context 'when the chosen category is full house' do
      it 'returns 0 unless the roll contains a pair AND a three of a kind' do
        roll = Roll.new
        roll.dices = [2, 2, 4, 5, 6]

        expect(RollScorer.new(roll, :full_house).compute_score).to eq(0)
      end

      it 'returns the sum of all dices in the roll if there are both' do
        roll = Roll.new
        roll.dices = [2, 2, 4, 4, 4]

        expect(RollScorer.new(roll, :full_house).compute_score).to eq(16)
      end
    end

    context 'when the chosen category is yahtzee' do
      it 'returns 0 unless all five dices are identical' do
        roll = Roll.new
        roll.dices = [2, 2, 4, 4, 4]

        expect(RollScorer.new(roll, :yahtzee).compute_score).to eq(0)
      end

      it 'returns 50 if all five dices are identical' do
        roll = Roll.new
        roll.dices = [4, 4, 4, 4, 4]

        expect(RollScorer.new(roll, :yahtzee).compute_score).to eq(50)
      end
    end

    context 'when the chosen category is chance' do
      it 'returns the sum of all dices' do
        roll = Roll.new
        roll.dices = [1, 1, 1, 1, 1]

        expect(RollScorer.new(roll, :chance).compute_score).to eq(5)
      end
    end
  end
end