require_relative './/roll'

class Game
  attr_reader :players
  attr_accessor :current_player
  class TooManyPlayersError < StandardError; end
  class PlayerHasNotFinishedTurn < StandardError; end

  def initialize(players)
    raise TooManyPlayersError, 'Sorry but you cannot be more than ten to play this game.' if players.length > 10
    @players = players
    @current_player = players.first
  end

  def throw_dices(player)
    player.roll = Roll.new
  end

  def has_ended?
    players.all? do |player|
      player.scoreboard_fully_filled?
    end
  end

  def write_points(category, points)
    current_player.scoreboard.write(category, points)

    next_turn
  end

  def next_turn
    current_player_index = players.find_index(current_player)
    @current_player = players[current_player_index + 1] || players.first
  end

  def compute_final_scores
    players.each_with_object({}) do |player, hash|
      hash[player.name.to_sym] = total_for(player)
    end
  end

  def total_for(player)
    player.scoreboard.categories.values.sum
  end

  def previous_player
    previous_player_index = players.find_index(current_player) - 1
    players[previous_player_index]
  end

  def winner
    final_scores = compute_final_scores
    return [] if draw?(final_scores)

    name, _score = winner_name_with_score(final_scores)
    players.find { |player| player.name == name.to_s}
  end

  def draw?(scores)
    scores.all? { |score| score[1] == scores.first[1]}
  end

  def max_score(scores)
    scores.values.max
  end

  def winner_name_with_score(scores)
    scores.find { |score| score[1] == max_score(scores)}
  end
end