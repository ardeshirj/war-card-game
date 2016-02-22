require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

until match.over?
  match.players_draw_cards(1)
  match.players_draw_cards(2) while match.war?
  match.update_winner_cards

  match.status
  puts
  # sleep(1)
end
