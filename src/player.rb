# Holds information about player's cards and id
class Player
  attr_accessor :id
  attr_accessor :cards

  def initialize(id, cards)
    @id = id
    @cards = cards
  end

  def add_cards(cards)
    @cards.push(cards)
  end

  def play_battel
    @cards.pop
  end

  def play_war
    @cards.pop(2)
  end
end
