module GameLoopComponents
  class MainLoop
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def main_loop
      until game.has_ended?
        puts "#{game.current_player.name} it is your turn to throw the dices"
        game.throw_dices(game.current_player)
        puts "You rolled #{game.current_player.roll.dices.to_s}" unless game.current_player.roll.dices.empty?
        answer = ''
        until answer == 'yes'
          puts "For which category would you like to use this roll?"
          selected_category = gets.chomp.gsub(' ', '_').to_sym
          score = RollScorer.new(game.current_player.roll, selected_category).compute_score
          puts "You will score #{score} points in this category. Is it okay for you?(yes, no)"
          answer = gets.chomp
        end
        begin
          game.write_points(selected_category, score)
        rescue Scoreboard::AlreadyWrittenForCategoryError
          puts 'You have already written points in this category. Please select an other one'
          answer = ''
          until answer == 'yes'
            puts "For which category would you like to use this roll?"
            selected_category = gets.chomp.gsub(' ', '_').to_sym
            score = RollScorer.new(game.current_player.roll, selected_category).compute_score
            puts "You will score #{score} points in this category. Is it okay for you?(yes, no)"
            answer = gets.chomp
          end
        end
        puts "\n\n"
        puts "#{game.current_player.name} Here is your current scoreboard:"
        puts game.current_player.scoreboard.show
        puts "\n\n"
      end
      puts 'The game has ended'
      puts 'Here are the results:'
      puts game.compute_final_scores
      puts "The winner is #{game.winner.name}, congratulation to you !"
      puts 'Hi hope you all had a nice time, I am looking forward to our next game'
    end
  end
end