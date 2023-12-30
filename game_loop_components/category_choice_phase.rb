class CategoryChoicePhase
  attr_reader :game
  def initialize(game)
    @game = game
  end

  def call
    answer = ''
    until answer == 'yes'
      puts "For which category would you like to use this roll?"
      selected_category = gets.chomp.gsub(' ', '_').to_sym
      score = RollScorer.new(game.current_player.roll, selected_category).compute_score
      puts "You will score #{score} points in this category. Is it okay for you?(yes, no)"
      answer = gets.chomp
    end
    [selected_category, score]
  end

end