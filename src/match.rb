require_relative './player.rb'

# Hold information about the players and cards
class Match
  attr_accessor :cards
  attr_accessor :players
  attr_accessor :pile

  def initialize(player_counts)
    suits = %w(c h s d) # (clubs, hearts, spades, diamonds)
    @card_set = %w(A K Q J) + ('2'..'10').to_a.reverse
    @cards = @card_set.product(suits).map { |c, _s| c.to_s }
    @players = setup_players(player_counts)
    @pile = []
  end

  def battel
    players_cards = {}
    @players.each do |player|
      player_card = player.play_cards(1)

      puts "player [#{player.id}]: #{player_card}"
      players_cards[player.id] = player_card

      @pile << player_card
    end
    players_cards
  end

  def war?(cards)
    cards.detect { |card| cards.count(card) > 1 }.nil?
  end

  def card_to_rank(player_cards)
    player_cards.map do |player_id, card|
      player_cards[player_id] = find_card_rank(card)
    end
  end

  def find_card_rank(card)
    @card_set.find_index(card) + 1
  end

  def find_player(player_id)
    @players.find { |player| player.id == player_id }
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
end
