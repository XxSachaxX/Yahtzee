class Roll
  attr_accessor :dices
  def initialize
    @dices = get_random_dices
  end

  def all_identical_dices?
    dices.all? { |digit| digit == dices.first}
  end

  def three_of_a_kind
    dices.select { |digit| dices.count(digit) == 3}
  end

  def three_of_a_kind?
    three_of_a_kind.empty?
  end

  def large_straight?
    dices.sort == CombinationsDictionary.large_straight
  end

  def small_straight?
    dices.sort == CombinationsDictionary.small_straight
  end

  def x_of_a_kind(x)
    dices.select { |digit| dices.count(digit) >= x}.take(x)
  end

  def paired_digits
    dices.select { |digit| dices.count(digit) == 2}
  end

  def paired_digits?
    paired_digits.empty?
  end

  private

  def get_random_dices
    5.times.map { |_i| rand(1..6)}
  end
end