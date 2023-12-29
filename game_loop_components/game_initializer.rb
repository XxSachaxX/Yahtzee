module GameLoopComponents
  class GameInitializer
    def self.create_game(number_of_players)
      created_players = self.create_players(number_of_players)

      Game.new(created_players)
    end

    def self.create_players(number_of_players)
      players = []
      number_of_players.times do |i|
        puts "What is the name of player #{i + 1}?"
        players << gets.chomp
      end
      players.map { |player| Player.new(player)}
    end
  end
end