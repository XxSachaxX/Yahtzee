require_relative 'combinations_dictionary'

class Scoreboard
  attr_accessor :categories
  class AlreadyWrittenForCategoryError < StandardError; end
  class CategoryDoesNotExistError < StandardError; end

  def initialize
    @categories = init_categories
  end

  def init_categories
    {
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
    }
  end

  def write(category, points)
    raise AlreadyWrittenForCategoryError, 'You already wrote down a score in this category, please try an other one' unless writeable?(category)
    raise CategoryDoesNotExistError, 'This category does not exist. Please pick one that does.' unless category_exists?(category)

    categories[category.to_sym] = points
  end

  def show
    categories.each_with_object('') do |category, string|
      formatted_category = category.to_s
      formatted_category.gsub!(/:/, '')
      formatted_category.gsub!(/,/, ':')
      formatted_category.gsub!('[', '')
      formatted_category.gsub!(']', '')
      formatted_category.gsub!('_', ' ')
      formatted_category.gsub!('nil', 'empty')
      string.concat("#{formatted_category}\n")
    end
  end

  private

  def writeable?(category)
    categories[category].nil?
  end

  def category_exists?(category)
    CombinationsDictionary.categories.include?(category)
  end
end