require_relative 'scoreboard'
class Player
  attr_reader :name
  attr_accessor :scoreboard, :roll

  def initialize(name)
    @name = name
    @scoreboard = Scoreboard.new
    @roll = []
  end

  def scoreboard_fully_filled?
    scoreboard.categories.values.all? { |category| !category.nil?}
  end
end