require_relative '../models/combinations_dictionary'
require_relative 'roll'

class RollScorer
  attr_reader :roll, :category
  YAHTZEE_VALUE = 50
  LARGE_STRAIGHT_VALUE = 20
  SMALL_STRAIGHT_VALUE = 15


  def initialize(roll, category)
    @roll = roll
    @category = category
  end

  def compute_score
    case category
    when :pair
      compute_pair_score
    when :two_pairs
      compute_two_pairs_score
    when :three_of_a_kind
      compute_x_of_a_kind(3)
    when :four_of_a_kind
      compute_x_of_a_kind(4)
    when :small_straight
      compute_small_straight
    when :large_straight
      compute_large_straight
    when :full_house
      compute_full_house
    when :yahtzee
      compute_yahtzee
    when :chance
      roll.dices.sum
    else
      compute_single_digit_category_score
    end
  end

  private

  def compute_yahtzee
    return 0 unless roll.all_identical_dices?

    YAHTZEE_VALUE
  end

  def compute_full_house
    return 0 if roll.paired_digits?
    return 0 if roll.three_of_a_kind?

    roll.dices.sum
  end

  def compute_large_straight
    return 0 unless roll.large_straight?

    LARGE_STRAIGHT_VALUE
  end

  def compute_small_straight
    return 0 unless roll.small_straight?

    SMALL_STRAIGHT_VALUE
  end

  def compute_x_of_a_kind(x)
    roll.x_of_a_kind(x).sum
  end

  def compute_pair_score
    roll.paired_digits.uniq.max * 2
  end

  def compute_two_pairs_score
    return 0 unless roll.paired_digits.count == 4

    roll.paired_digits.sum
  end

  def compute_single_digit_category_score
    digit_corresponding_to_category = CombinationsDictionary.digit_for(category)
    roll.dices.select { |digit| digit == digit_corresponding_to_category}.sum
  end
end