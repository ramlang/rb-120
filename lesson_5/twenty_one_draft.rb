=begin

*** Initial Steps ***
1. Write description of the problema and extract major nouns and verbs
2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code
3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards

*** Game description ***
Twenty-one is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over...

Overview:
- both players dealt two cards from the 52 card deck
- player takes the first turn and can hit or stay
- if the player busts he loses, if he stays it's the dealers turn
- the dealer must hit until his cards add up to at least 17
- If he busts, the player wins. If both players and dealer stays, then the highest total wins
- If both totals are equal then it's a tie and nobody wins

*** Nouns and Verbs ***
Nouns: player, card, deck, dealer, total, participant, game
Verbs: deal, hit, stay, bust

*** Organize ***
Player
- card
- hit
- stay
- busted?
-total

Dealer
- hit
- stay
- busted?
- total
- deal (maybe place in Deck instead?)

Participant

Deck
- deal (maybe place in Dealer instead?)

Card

Game
- start
=end
# *** Spike ***
# reference implemenation uses a Hand module that is mixed in the the Player and Dealer class

module Hand

  def display_cards
    num = 1
    @cards.each do |card|
      puts "Card #{num}: #{card}"
      num += 1
    end
  end

  def hide_cards
    num = 1
    @cards.each do |card|
      num == 1 ? (puts "Card #{num}: #{card}") : (puts "Card #{num}: ???")
      num += 1
    end
  end

  def calculate_total
    @total = raw_total
    adjust_total if @total > 21
  end

  def number_of_aces
    @cards.count { |card| card.value == 'Ace' }
  end

  def adjust_total
    number_of_aces.times do |_|
      return @total if @total <= 21
      @total -=  10
    end
  end

  def raw_total
    @cards.inject(0) { |sum, card| sum + (card.points) }
  end

  def display_total
    puts "#{self.class} Total: #{self.total}"
  end

  def hide_total
    puts "#{self.class} Total: ???"
  end

  def bust?
    @total > 21
  end
end

class Deck
  attr_accessor :deck

  def initialize
    @deck = create_deck.shuffle
  end

  def create_deck
    suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
    values = (2..10).to_a + ['Queen', 'King', 'Ace', 'Jack']
    suits.product(values).map do |suit, value|
      Card.new(suit, value)
    end
  end

  def shuffle
    @deck.shuffle!
  end

  def reset
    @deck = create_deck.shuffle
  end

  def deal(num)
    deck.shift(num)
  end
end

class Player
  include Hand
  attr_accessor :cards
  attr_writer :total

  def initialize
    @cards = []
    @total = 0
    # @name = set_name
  end

  def total
    calculate_total
    @total
  end

  # def set_name; end
end

class Dealer
  attr_accessor :cards
  attr_writer :total
  include Hand

  def initialize
    @cards = []
    @total = 0
  end

  def total
    calculate_total
    @total
  end
end

class Participant;end

class Card
  attr_accessor :suit, :value, :points

  def initialize(suit, value)
    @suit = suit
    @value = value
    @points = worth
  end

  def to_s
    "#{value} of #{suit}"
  end

  def worth
    if value[0] == 'A'
      11
    elsif value.to_i == 0
      10
    else
      value
    end
  end
end

class Game
  attr_accessor :player, :dealer, :current_deck

  def initialize
    @current_deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    # display_welcome_message
    loop do
      deal_cards
      show_cards
      player_turn
      dealer_turn unless someone_bust?
      show_result
      break unless play_again?
      deck.reset
    end
    # display_goodbye_message
  end

  def deal_cards
    @player.cards = @current_deck.deal(2)
    @dealer.cards = @current_deck.deal(2)
  end

  def show_cards
    system 'clear'
    puts "Dealer Hand:"
    @dealer.hide_cards
    @dealer.hide_total # create a separate method to display stats 
    puts ""
    puts "Player Hand:"
    @player.display_cards
    @player.display_total
    puts ""
  end

  def hit_or_stay
    answer = nil
    loop do
      puts "Would you like to hit or stay?"
      answer = gets.chomp.downcase
      break if %w(hit stay).include?(answer)
      puts "Sorry that's not a valid choice..."
    end
    answer
  end

  def player_turn
    loop do
      choice = hit_or_stay
      hit(player) unless choice == 'stay'
      show_cards
      break if @player.bust? || choice == 'stay'
    end
  end

  def hit(name)
    name.cards.concat(@current_deck.deal(1))
  end

  def dealer_turn
    loop do
      if dealer.total < 17
        hit(dealer)
        show_cards
      else
        choice = 'stay'
      end
      break if @dealer.bust? || choice == 'stay'
    end
  end

  def someone_bust?
    player.bust? || dealer.bust?
  end

  def game_over
    if player.bust?
      puts "Player busted! Dealer wins!"
    else
      puts "Dealer busted! Player wins!"
    end
  end

  def determine_winner
    if someone_bust?
      game_over
    elsif player.total > dealer.total
      puts "Player wins!"
    elsif player.total < dealer.total
      puts "Dealer wins!"
    else
      puts "It's a tie!"
    end
  end

  def show_result
    system 'clear'
    puts "Dealer Hand:"
    @dealer.display_cards
    @dealer.display_total 
    puts ""
    puts "Player Hand:"
    @player.display_cards
    @player.display_total
    puts ""
    determine_winner
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry that's not a valid choice..."
    end
    answer = nil if %w(n no).include?(answer)
    answer
  end

  # def display_welcome_message;end

  # def display_goodbye_message;end

end

 Game.new.start
