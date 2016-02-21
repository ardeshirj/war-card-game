require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

until match.over?
  match.players_draw_card(1)

  match.players_draw_card(2) while match.war?

  match.update_winner_cards
end
