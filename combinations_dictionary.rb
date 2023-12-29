class CombinationsDictionary
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