require_relative './player.rb'

# Hold information about the players and cards
class Match
  attr_accessor :cards
  attr_accessor :players

  def initialize(player_counts)
    suits = %w(c h s d) # (clubs, hearts, spades, diamonds)
    card_set = ('2'..'9').to_a + %w(A K Q J T)
    @cards = card_set.product(suits).map { |c, _s| c.to_s }
    @players = setup_players(player_counts)
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
