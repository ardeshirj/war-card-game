require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

until match.over?
  puts 'Match not over yet'

  match.player_draw_card(1)
  match.update_winner_cards

  exit

  # while !match.war?(players_cards.values)
  #   puts 'We are in the war'
  #   break
  # end
end
