require_relative '../models/game'
require_relative 'roll_scorer'
require_relative 'player'
require_relative '../game_loop_components/introduction'
require_relative '../game_loop_components/main_loop'
require_relative '../game_loop_components/game_initializer'


puts GameLoopComponents::Introduction.text

number_of_players = gets.chomp.to_i
game = GameLoopComponents::GameInitializer.create_game(number_of_players)

puts "Let's begin."
GameLoopComponents::MainLoop.new(game).main_loop