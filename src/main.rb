require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

zone = {}
match.players.each do |player|
  player_card = player.play_battel
  puts "player [#{player.id}]: #{player_card}."
  zone[player.id] = match.find_card_rank(player_card)
end
p zone
