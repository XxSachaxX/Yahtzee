class RollingPhase
  attr_reader :game
  def initialize(game)
    @game = game
  end

  def call
    puts "#{game.current_player.name} it is your turn to throw the dices"
    game.throw_dices(game.current_player)
    puts "You rolled #{game.current_player.roll.dices.to_s}" unless game.current_player.roll.dices.empty?
  end
end