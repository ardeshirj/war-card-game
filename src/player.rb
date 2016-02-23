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

  def draw_cards(card_count)
    poped = []
    (1..card_count).each { poped << @cards.pop }
    poped
  end

  def ==(other)
    @id == other.id
  end
end
