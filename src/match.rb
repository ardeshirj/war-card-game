require_relative './player.rb'

# Hold information about the players and cards
class Match
  attr_accessor :cards
  attr_accessor :players

  def initialize(player_counts)
    suits = %w(c h s d) # (clubs, hearts, spades, diamonds)
    @card_set = %w(A K Q J) + ('2'..'10').to_a.reverse
    @cards = @card_set.product(suits).map { |c, _s| c.to_s }
    @players = setup_players(player_counts)
  end

  def find_card_rank(card)
    @card_set.find_index(card) + 1
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
