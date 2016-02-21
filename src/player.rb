# Holds information about player's cards and id
class Player
  attr_accessor :id
  attr_accessor :cards

  def initialize(id, cards)
    @id = id
    @cards = cards
  end

  def add_cards(cards)
    @cards.unshift(*cards)
  end

  def play_cards(n)
    @cards.pop(n)
  end
end
