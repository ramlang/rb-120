module Hand
  TARGET_VALUE = 21

  def display_hand(view= :show)
    puts "~ #{name}'s Hand ~".center(48)
    puts Game::DASHED_LINE
    display_cards(view)
    puts Game::DASHED_LINE
    display_total(view)
  end

  def display_cards(view= :show)
    @cards.each_with_index do |card, ind|
      ind += 1
      if view == :hide && ind != 1
        puts format("%36s", "Card #{ind}: ???".ljust(24))
      else
        puts format("%36s", "Card #{ind}: #{card}".ljust(24))
      end
    end
  end

  def hit(new_card)
    cards.concat(new_card)
  end

  def bust?
    @total > TARGET_VALUE
  end

  def number_of_aces
    @cards.count { |card| card.value == 'Ace' }
  end

  def adjust_total
    number_of_aces.times do |_|
      return @total if @total <= TARGET_VALUE
      @total -= 10
    end
  end

  def total_points
    @cards.inject(0) { |sum, card| sum + (card.points) }
  end

  def calculate_total
    @total = total_points
    adjust_total if bust?
    @total
  end

  def display_total(view= :show)
    if view == :hide
      puts "Total: ???".rjust(48)
    else
      puts "Total: #{total}".rjust(48)
    end
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

class Participant
  attr_accessor :cards, :score
  attr_writer :total

  include Hand

  def initialize
    @cards = []
    @total = 0
    @score = 0
  end

  def total
    calculate_total
    @total
  end

  def increment_score
    @score += 1
  end

  def reset
    @cards = []
    @total = 0
  end
end

class Player < Participant
  attr_reader :name

  def initialize
    super
    @name = set_name
  end

  def set_name
    answer = nil
    loop do
      print "Enter your name: "
      answer = gets.chomp
      break unless answer.empty?
      puts "Sorry that's not a valid name..."
    end
    answer
  end

  def move
    answer = nil
    loop do
      puts "Would you like to hit or stay? (h/s)"
      answer = gets.chomp.downcase
      break if %w(hit h stay s).include?(answer)
      puts "Sorry that's not a valid choice..."
    end
    answer
  end
end

class Dealer < Participant
  attr_reader :name

  def initialize
    super
    @name = set_name
  end

  def set_name
    ['2B', '9S', 'Tron', 'Marvin'].sample
  end
end

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
  GAME_TITLE = "Twenty One"
  DASHED_LINE = "-" * 48
  WINNING_SCORE = 5

  attr_accessor :player, :dealer, :current_deck

  def initialize
    @current_deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    clear_table
    display_welcome_message
    game_play
    display_goodbye_message
  end

  private

  def game_play
    loop do
      deal_cards
      display_table(:hide)
      player_turn
      dealer_turn unless someone_bust?
      end_round
      break unless play_again?
      reset_score if game_winner?
      current_deck.reset
    end
  end

  def clear_table
    system 'clear'
  end

  def dramatic_pause
    sleep(1.6)
  end

  def continue?
    puts "Press ENTER to continue..."
    STDIN.gets
  end

  # rubocop:disable Metrics/MethodLength
  def game_intro
    puts ""
    puts "     _______    _______    _______    _______"
    puts "    |2      |  |3      |  |5      |  |A      |"
    puts "    |       |  |  / \\  |  |       |  |   _   |"
    puts "    | / V \\ |  | /   \\ |  |  / \\  |  |  ( )  |"
    puts "    | \\   / |  | \\   / |  | (_ _) |  | (_ _) |"
    puts "    |   v   |  |  \\ /  |  |   |   |  |   |   |"
    puts "    |      2|  |      3|  |      5|  |      A|"
    puts "    |_______|  |_______|  |_______|  |_______|"
    puts ""
    puts "            ~ Let's play #{GAME_TITLE}! ~"
    puts ""
    puts "Get the sum of your cards close to or equal to #{Hand::TARGET_VALUE}."
    puts "If you go over #{Hand::TARGET_VALUE} or the dealer is closer"
    puts "you lose!"
    puts ""
  end
  # rubocop:enable Metrics/MethodLength

  def display_welcome_message
    game_intro
    continue?
    clear_table
  end

  def reset_hands
    player.reset
    dealer.reset
  end

  def deal_cards
    reset_hands
    player.hit(current_deck.deal(2))
    dealer.hit(current_deck.deal(2))
  end

  def scoreboard
    puts "Objectitve: Win #{WINNING_SCORE} games!"
    puts DASHED_LINE
    puts "~ Scoreboard ~".center(48)
    display_scores
    puts ""
  end

  # rubocop:disable Metrics/AbcSize
  def display_scores
    puts DASHED_LINE
    puts player.name.to_s.center(24) + "|" + dealer.name.to_s.center(24)
    puts player.score.to_s.center(24) + "|" + dealer.score.to_s.center(24)
    puts DASHED_LINE
  end
  # rubocop:enable Metrics/AbcSize

  def display_table(view= :show)
    clear_table
    scoreboard
    dealer.display_hand(view)
    puts ""
    player.display_hand
    puts ""
  end

  def player_turn
    loop do
      choice = player.move
      player.hit(current_deck.deal(1)) unless %w(stay s).include?(choice)
      display_table(:hide)
      break if player.bust? || %w(stay s).include?(choice)
    end
  end

  def dealer_turn
    loop do
      break unless dealer.total < 17
      dealer.hit(current_deck.deal(1))
      display_table(:hide)
      puts "#{dealer.name} hits!"
      dramatic_pause
    end
    display_table(:hide)
    puts "#{dealer.name} stays!"
    dramatic_pause
  end

  def someone_bust?
    player.bust? || dealer.bust?
  end

  def game_over
    if player.bust?
      :player_bust
    else
      :dealer_bust
    end
  end

  def determine_winner
    if someone_bust?
      game_over
    elsif player.total > dealer.total
      :player
    elsif player.total < dealer.total
      :dealer
    else
      :tie
    end
  end

  def update_score
    case determine_winner
    when :player, :dealer_bust then player.increment_score
    when :dealer, :player_bust then dealer.increment_score
    end
  end

  def reset_score
    player.score = 0
    dealer.score = 0
  end

  def display_winner
    case determine_winner
    when :player_bust then "#{player.name} busted! #{dealer.name} wins!"
    when :dealer_bust then "#{dealer.name} busted! #{player.name} wins!"
    when :player      then "#{player.name} wins!"
    when :dealer      then "#{dealer.name} wins!"
    when :tie         then "It's a tie!"
    end
  end

  def show_result
    update_score
    display_table
    puts display_winner unless game_winner?
  end

  def game_winner?
    player.score == WINNING_SCORE || dealer.score == WINNING_SCORE
  end

  def display_game_winner
    if player.score == WINNING_SCORE
      puts "#{player.name} won #{WINNING_SCORE} games! #{player.name} wins!"
    else
      puts "#{dealer.name} won #{WINNING_SCORE} games! #{dealer.name} wins!"
    end
  end

  def end_round
    show_result
    display_game_winner if game_winner?
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (yes/no)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry that's not a valid choice..."
    end
    return false if %w(n no).include?(answer)
    answer
  end

  def display_goodbye_message
    puts "Thanks for playing #{GAME_TITLE}! Goodbye!"
  end
end

Game.new.start
