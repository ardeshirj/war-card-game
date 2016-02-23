require_relative './match.rb'
require_relative './player.rb'

match = Match.new(2)

until match.over?

  puts '---Battel---'
  match.players_draw_cards(1)

  while match.war?
    puts 'Result: WAR'
    puts '---End------'

    puts

    puts '---WAR---'
    match.players_draw_cards(2)
  end

  puts "Result: #{match.update}"
  puts '---End---'
  puts

  sleep(1)
end
