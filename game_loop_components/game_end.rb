module GameLoopComponents
  class GameEnd
    attr_reader :game
    def initialize(game)
      @game = game
    end

    def call
      puts 'The game has ended'
      puts 'Here are the results:'
      puts game.compute_final_scores
      puts "The winner is #{game.winner.name}, congratulation to you !"
      puts 'I hope you all had a nice time, I am looking forward to our next game'
    end
  end
end