require_relative './player.rb'

# Hold information about the players and cards
class Match
  attr_accessor :cards
  attr_accessor :players

  def initialize(player_counts)
    suits = %w(c h s d) # (clubs, hearts, spades, diamonds)
    # [2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A]
    @card_set = ('2'..'10').to_a + %w(J Q K A)
    @cards = @card_set.product(suits).map { |c, _s| c.to_s }
    @players = setup_players(player_counts)
    @played_cards = {}
  end

  def battel
    @players.each do |player|
      player_card = player.play_cards(1)

      puts "player [#{player.id}]: #{player_card}"
      @played_cards[player.id] = player_card
    end
  end

  def find_battel_winner
    cards_rank = {}

    @played_cards.map do |player_id, card|
      cards_rank[player_id] = @card_set.find_index(card) + 2
    end

    winner_card = cards_rank.max_by { |_player_id, card_rank| card_rank }
    puts "player [#{winner_card[0]}] wins with rank: #{winner_card[1]}"

    find_player(winner_card[0])
  end

  def pile_cards
    @played_cards.values
  end

  def war?(played_cards)
    @played_cards.detect { |card| played_cards.count(card) > 1 }
  end

  def over?
    @players.detect { |player| player.cards.size == @cards.size }
  end

  private

  def setup_players(player_counts)
    @players = []
    game_cards = cards.shuffle
    cards_count = game_cards.size

    (1..player_counts).map do |player_count|
      player_cards = game_cards.pop(cards_count / player_counts)
      Player.new(player_count, player_cards)
    end
  end

  def find_player(player_id)
    @players.find { |player| player.id == player_id }
  end
end
