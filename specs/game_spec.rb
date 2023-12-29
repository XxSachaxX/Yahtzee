require_relative '../game'
require_relative '../roll'
require_relative '../player'

describe Game do
  context 'A new game' do
    it 'is created with at least 2 players' do
      expect(Game.new(%w[John Yoko]).players.count).to be >= 2
    end

    it 'is created with a maximum of 10 players' do
      expect { (Game.new(%w[John Yoko Paul Eric Jimmy Ringo George Steve Thomas Cindy Madonna])) }.to raise_error(Game::TooManyPlayersError)
    end
  end

  context 'when a game is ongoing' do
    it 'allows a player to roll the dices' do
      player_1 = Player.new('John')
      player_2 = Player.new('Yoko')
      game = Game.new([player_1, player_2])

      expect(game.throw_dices(player_1)).to be_instance_of(Roll)
      expect(player_1.roll).to be_instance_of(Roll)
    end
  end

  context 'the game' do
    it 'should know who\'s turn it is to play' do
      player_1 = Player.new('John')
      player_2 = Player.new('Yoko')
      game = Game.new([player_1, player_2])

      expect(game.current_player).to eq(player_1)
    end
  end

  it 'should know which player played the turn before' do
    player_1 = Player.new('John')
    player_2 = Player.new('Yoko')
    game = Game.new([player_1, player_2])
    game.throw_dices(player_1)
    game.write_points(:chance, game.current_player.roll)

    expect(game.previous_player).to be(player_1)
  end

  context 'when a player has played his turn' do
    it 'should change turn to the next player' do
      player_1 = Player.new('John')
      player_2 = Player.new('Yoko')
      game = Game.new([player_1, player_2])
      game.throw_dices(player_1)

      expect { game.write_points(:chance, game.current_player.roll) }.to change { game.current_player }
    end
  end

  context 'when players have not filled their board' do
    it 'the game is ongoing' do
      player_1 = Player.new('John')
      player_2 = Player.new('Yoko')
      game = Game.new([player_1, player_2])
      scoreboard = Scoreboard.new
      scoreboard.categories ={
        ones: nil,
        twos: nil,
        threes: nil,
        fours: nil,
        fives: nil,
        sixes: nil,
        pair: nil,
        two_pairs: nil,
        three_of_a_kind: nil,
        four_of_a_kind: nil,
        small_straight: nil,
        large_straight: nil,
        full_house: nil,
        yahtzee: nil,
        chance: nil
      }
      player_1.scoreboard = scoreboard
      player_2.scoreboard = scoreboard

      expect(game.has_ended?).to be false
    end
  end

  context 'when all players have filled their scoreboards' do
    it 'ends the game' do
      player_1 = Player.new('John')
      player_2 = Player.new('Yoko')
      game = Game.new([player_1, player_2])
      scoreboard = Scoreboard.new
      scoreboard.categories ={
        ones: 1,
        twos: 2,
        threes: 3,
        fours: 4,
        fives: 5,
        sixes: 5,
        pair: 6,
        two_pairs: 7,
        three_of_a_kind: 8,
        four_of_a_kind: 9,
        small_straight: 0,
        large_straight: 0,
        full_house: 0,
        yahtzee: 0,
        chance: 10
      }
      player_1.scoreboard = scoreboard
      player_2.scoreboard = scoreboard

      expect(game.has_ended?).to be true
    end
  end

  context 'when the game has ended' do
    it 'computes each players scores' do
      player_1 = Player.new('John')
      player_2 = Player.new('Yoko')
      game = Game.new([player_1, player_2])
      scoreboard = Scoreboard.new
      scoreboard.categories ={
        ones: 1,
        twos: 2,
        threes: 3,
        fours: 4,
        fives: 5,
        sixes: 5,
        pair: 6,
        two_pairs: 7,
        three_of_a_kind: 8,
        four_of_a_kind: 9,
        small_straight: 0,
        large_straight: 0,
        full_house: 0,
        yahtzee: 0,
        chance: 10
      }
      player_1.scoreboard = scoreboard
      player_2.scoreboard = scoreboard

      expect(game.compute_final_scores).to eq({John: 60, Yoko: 60})
    end
  end

  context 'when the game has ended' do
    context 'if a player has a higher score than others' do
      it 'is the winner' do
        player_1 = Player.new('John')
        player_2 = Player.new('Yoko')
        game = Game.new([player_1, player_2])
        player_1_scoreboard = Scoreboard.new
        player_1_scoreboard.categories ={
          ones: 1,
          twos: 2,
          threes: 3,
          fours: 4,
          fives: 5,
          sixes: 5,
          pair: 6,
          two_pairs: 7,
          three_of_a_kind: 8,
          four_of_a_kind: 9,
          small_straight: 0,
          large_straight: 0,
          full_house: 0,
          yahtzee: 0,
          chance: 10
        }
        player_1.scoreboard = player_1_scoreboard

        player_2_scoreboard = Scoreboard.new
        player_2_scoreboard.categories ={
          ones: 1,
          twos: 2,
          threes: 3,
          fours: 4,
          fives: 5,
          sixes: 5,
          pair: 6,
          two_pairs: 7,
          three_of_a_kind: 8,
          four_of_a_kind: 9,
          small_straight: 0,
          large_straight: 0,
          full_house: 0,
          yahtzee: 50,
          chance: 10
        }
        player_2.scoreboard = player_2_scoreboard

        expect(game.winner).to eq(player_2)
      end
    end

    context 'if all players have the same scores' do
      it 'is a draw' do
        player_1 = Player.new('John')
        player_2 = Player.new('Yoko')
        game = Game.new([player_1, player_2])
        scoreboard = Scoreboard.new
        scoreboard.categories ={
          ones: 1,
          twos: 2,
          threes: 3,
          fours: 4,
          fives: 5,
          sixes: 5,
          pair: 6,
          two_pairs: 7,
          three_of_a_kind: 8,
          four_of_a_kind: 9,
          small_straight: 0,
          large_straight: 0,
          full_house: 0,
          yahtzee: 0,
          chance: 10
        }
        player_1.scoreboard = scoreboard
        player_2.scoreboard = scoreboard

        expect(game.winner).to eq([])
      end
    end
  end
end