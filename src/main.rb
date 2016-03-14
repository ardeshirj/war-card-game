require_relative './match.rb'
require_relative './player.rb'
require_relative './card.rb'

if ARGV.empty? || ARGV.size < 1
  puts 'Usage: main.rb number_of_players'
  puts 'number_of_players - enter a number between 2-4'
  exit
end

number_of_players = ARGV[0].to_i
unless number_of_players.between?(2, 4)
  puts 'Please enter a number between 2-4'
  exit
end

match = Match.new(number_of_players)

until match.over?

  puts '---Battel---'
  match.players_draw_cards(1)
  Card.show_last_played_cards(match, false)

  while match.war?
    puts 'Result: WAR'
    puts '---End------'

    puts

    puts '---WAR---'
    match.players_draw_cards(2)
    Card.show_last_played_cards(match, true)
  end

  puts "Result: #{match.update}"
  puts '---End---'
  puts

  sleep(1)
end
