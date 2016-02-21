require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

until match.over?
  puts 'Match not over yet'

  match.battel
  battel_winner = match.find_battel_winner

  puts "Winner cards (before) #{battel_winner.cards}"
  battel_winner.add_cards(match.pile_cards)
  puts "winner cards (after) #{battel_winner.cards}"

  exit

  # while !match.war?(players_cards.values)
  #   puts 'We are in the war'
  #   break
  # end
end
