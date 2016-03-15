# Holds information about player's cards and id
class Player
  attr_reader :id
  attr_accessor :cards

  def initialize(id, cards)
    @id = id
    @cards = cards
  end

  def add_cards(cards)
    @cards.unshift(*cards)
  end

  def draw_cards(card_count)
    poped = []
    (1..card_count).each { poped << @cards.pop }
    poped
  end

  def self.find_player(players, player_id)
    players.find { |player| player.id == player_id }
  end

  def self.delete_lost_players(players, cards_rank)
    # Remove the lost players (player with card_rank = 0)
    lost_player = nil
    cards_rank.each do |player_id, card_rank|
      if card_rank == 0
        lost_player = find_player(players, player_id)
        players.delete(lost_player)
      end
    end
  end

  def ==(other)
    @id == other.id
  end
end
