# Draw
# p1_cards = %w(Q 2 7)
# p2_cards = %w(Q 2 7)

# A player run out of card during the war
# p1_cards = %w(2 7)
# p2_cards = %w(Q 2 7)

p1_cards = %w( A A A A K K K K Q Q Q Q J J J J 10 10 10 10 9 9 9 9 8 8 8 8)
p2_cards = %w( 7 7 7 7 6 6 6 6 5 5 5 5 4 4 4 4 3 3 3 3 2 2 2 2)

p1_cards = %w( 2 Q k K A A )
p2_cards = %w( 10 Q K K A A )


# Face down is last card (5 in p1_cards)
# p1_cards = %w(Q 7)
# p2_cards = %w(9 6 Q 2 7)

players = []
players << Player.new(1, p1_cards)
players << Player.new(2, p2_cards)
players

# If you don't have enough cards to "complete the war", you lose. DONE
# If neither player has enough cards, the one who runs out first loses.
# If both run out simultaneously, it's a draw (last play was a war too)

# During the way!
# If you run out of cards during a war, your last card is turned face up
# and is used for all battles in that war. If this happens to both players
# in a war and their last cards are equal the game is a draw
