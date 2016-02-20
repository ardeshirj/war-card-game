require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

players_cards = match.battel
p match.war?(players_cards.values)

winner_card = zone.min_by { |_player_id, card_rank| card_rank }
puts "player [#{winner_card[0]}] wins with rank: #{winner_card[1]}"

winner = match.find_player(winner_card[0])
puts "Winner cards #{winner.cards}"
winner.add_cards(played_cards)
puts "winner cards #{winner.cards}"
