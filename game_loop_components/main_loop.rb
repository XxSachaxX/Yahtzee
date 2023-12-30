require_relative './rolling_phase'
require_relative './scoreboard_display'
require_relative './category_choice_phase'
require_relative './game_end'

module GameLoopComponents
  class MainLoop
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def call
      until game.has_ended?
        RollingPhase.new(game).call

        begin
        selected_category, score = CategoryChoicePhase.new(game).call
          game.write_points(selected_category, score)
        rescue Scoreboard::AlreadyWrittenForCategoryError
          puts 'You have already written points in this category. Please select an other one'
          retry
        rescue Scoreboard::CategoryDoesNotExistError
          puts 'This category does not exist. Please select one that does'
          retry
        end
        ScoreboardDisplay.new(game).call
      end
    end
  end
end