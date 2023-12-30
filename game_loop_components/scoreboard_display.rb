class ScoreboardDisplay
  attr_reader :game
  def initialize(game)
    @game = game
  end

  def call
    puts "\n\n"
    puts "#{game.current_player.name} Here is your current scoreboard:"
    puts game.current_player.scoreboard.show
    puts "\n\n"
  end
end