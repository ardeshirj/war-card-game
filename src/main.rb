require_relative './match.rb'
require_relative './player.rb'

new_match = Match.new(2)
new_match.players.each { |player| p player.cards.size }
