require_relative './player.rb'

# Hold information about the players and cards
class Match
  attr_accessor :cards
  attr_accessor :players

  def initialize(player_count)
    suits = %w(c h s d) # (clubs, hearts, spades, diamonds)
    # [2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A]
    @card_set = ('2'..'10').to_a + %w(J Q K A)
    @cards = @card_set.product(suits).map { |c, _s| c.to_s }
    @players = setup_players(player_count)
    @pile = Hash.new { |hash, key| hash[key] = [] }
  end

  def players_draw_cards(card_count)
    @players.each do |player|
      player_cards = player.draw_cards(card_count)

      puts "player #{player.id}: #{player_cards}"
      player_cards.each { |player_card| @pile[player.id] << player_card }
    end
  end

  def update_winner_cards
    return if @pile.size == 1

    won_cards = lost_players_cards
    cards_rank = find_cards_rank
    # puts "Ranks #{cards_rank}"

    winner_player_card = cards_rank.max_by { |_player_id, card_rank| card_rank }
    winner = find_player(winner_player_card[0])
    winner.add_cards(@pile.values.flatten + won_cards)

    # puts "Winner: player-#{winner.id}"
    # puts @pile
    @pile.clear
  end

  def remove_no_cards_player
    @players.delete_if { |player| player.cards.empty? }
  end

  def status
    @players.each do |player|
      puts "Player[#{player.id}]: #{player.cards}"
    end
  end

  def war?
    return false if @pile.size == 1
    equal_cards = @pile.values.detect do |card|
      @pile.values.count(card) > 1
    end
    equal_cards ? (return true) : (return false)
  end

  def over?
    return true if @players.size == 1
    winner = @players.detect { |player| player.cards.size == @cards.size }
    winner.nil? ? false : true
  end

  private

  def setup_players(player_counts)
    game_cards = cards.shuffle
    cards_count = game_cards.size

    (1..player_counts).map do |player_count|
      player_cards = game_cards.pop(cards_count / player_counts)
      Player.new(player_count, player_cards)
    end
  end

  def find_player(player_id)
    @players.find { |player| player.id == player_id }
  end

  def find_cards_rank
    cards_rank = {}
    @pile.each do |player_id, cards|
      cards_rank[player_id] = @card_set.find_index(cards.last) + 2
    end
    cards_rank
  end

  def find_lost_players
    lost_players = []
    @pile.each do |player_id, cards|
      lost_players << player_id if cards.include?(nil)
    end
    lost_players
  end

  def lost_players_cards
    lost_players = find_lost_players
    lost_player_cards = []

    lost_players.each do |player_id|
      lost_player_cards += @pile[player_id].compact
      @players.delete_if { |player| player.id == player_id }
      @pile.delete(player_id)
    end

    lost_player_cards
  end
end
