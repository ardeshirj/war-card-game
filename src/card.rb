# Hold information about the game cards
class Card
  attr_reader :deck

  def initialize(shuffle = true)
    # (clubs, hearts, spades, diamonds)
    # [2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A]

    suits = %w(c h s d)
    card_set = ('2'..'10').to_a + %w(J Q K A)
    @deck = card_set.product(suits).map { |c, _s| c.to_s }
    @deck.shuffle! if shuffle
  end

  def size
    @deck.size
  end

  def pass_card(count)
    @deck.pop(count)
  end

  def self.rank(played_cards)
    cards_rank = {}
    card_set = ('2'..'10').to_a + %w(J Q K A)

    played_cards.each do |player_id, cards|
      rank = 0
      rank = card_set.find_index(cards.last) + 2 unless cards.last.nil?
      cards_rank[player_id] = rank
    end
    cards_rank
  end

  def self.show_played_cards(player, played_cards, draw_war_cards)
    print "Player[#{player.id}] (##{player.cards.size} cards):"
    if draw_war_cards
      war_cards = []
      played_cards.each_index do |index|
        index.even? ? war_cards << 'X' : war_cards << played_cards[index]
      end
      puts "#{war_cards}"
    else
      puts "#{played_cards}"
    end
    # p player.cards
  end
end
