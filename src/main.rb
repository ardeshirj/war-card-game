require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

zone = {}
played_cards = []

match.players.each do |player|
  player_card = player.play_battel

  puts "player [#{player.id}]: #{player_card}"
  zone[player.id] = match.find_card_rank(player_card)

  played_cards << player_card
end

winner_card = zone.min_by { |_player_id, card_rank| card_rank }
puts "player [#{winner_card[0]}] wins with rank: #{winner_card[1]}"

winner = match.find_player(winner_card[0])
puts "Winner cards #{winner.cards}"
winner.add_cards(played_cards)
puts "winner cards #{winner.cards}"
