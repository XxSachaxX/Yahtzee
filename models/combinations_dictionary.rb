class CombinationsDictionary
  
  def self.categories
    [
      :ones,
      :twos,
      :threes,
      :fours,
      :fives,
      :sixes,
      :pair,
      :two_pairs,
      :three_of_a_kind,
      :four_of_a_kind,
      :small_straight,
      :large_straight,
      :full_house,
      :yahtzee,
      :chance
    ]
  end

  def self.displayable_categories
    "ones\ntwos\nthrees\nfours\nfives\nsixes\npair\ntwo pairs\ntwos\nthree of a kind\nfour of a kind\nsmall_straight\nlarge_straight\nfull_house\nyahtzee\nchance\n"
  end

  def self.digit_categories
    {
      ones: 1,
      twos: 2,
      threes: 3,
      fours: 4,
      fives: 5,
      sixes: 6
    }
  end

  def self.digit_for(category)
    self.digit_categories[category]
  end

  def self.small_straight
    [1, 2, 3, 4, 5]
  end

  def self.large_straight
    [2, 3, 4, 5, 6]
  end
end