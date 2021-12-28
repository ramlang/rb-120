=begin
Tic Tac Toe

Breaking down the problem...
1. write a description of the problem; extract major nouns and verbs
2. Make an initial guess at organizing the verbs into nouns; do a spike
3. Optional - when you have a better idea of the problem model into CRC cards

Game description:
Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
marking a square. The first player to mark 3 squares in a row wins

Nouns: board, grid, square, player
Verbs: play, mark

Organized:
board
square
player
- play
- mark

class Board
  def initialize
    # we need someway to model the 3x3 grid. Maybe squares?
    # what data structure should we use?
    # - array/hash of square objects?
    # - array/hash of string or integers?
  end
end

class Square
  def initialize
    # maybe a status to keep track of this squares work?
  end
end

class Players
  def initialize
    # maybe a marker to keep track of this player's symbol ('X' or 'O')
  end

  def mark

  end

  def play

  end
end

class TTTGame
  def play

  end
end

game = TTTGame.new
game.play

# adding more to TTTGame
class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_results
    display_goodbye_message
  end
end

=end

# Spike...
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def find_a_square(line, player_marker) # something about a guard clause? using unless?
    squares = @squares.values_at(*line)
    if squares.select(&:marked?).collect(&:marker).count(player_marker) == 2
      @squares.select do |k, v|
        line.include?(k) && (v.marker == Square::INITIAL_MARKER)
      end.keys.first
    end
  end

  private

  def three_identical_markers?(squares) # returns true or false
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end
# ********************
class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker= INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end
# ********************
class Player
  attr_accessor :score, :name

  def initialize
    @score = 0
    @name = set_name
  end

  def set_name
    user_name = nil
    loop do
      puts "Please enter your name:"
      user_name = gets.chomp.capitalize
      break unless user_name.empty?
      puts "Sorry that's not a valid choice..."
    end
    user_name
  end

  def add_point
    @score += 1
  end

  def winning_score?
    score == TTTGame::WINNING_POINTS
  end

  def reset_score
    @score = 0
  end
end
# ********************
class Human < Player
  attr_reader :marker

  def initialize
    @marker = choose_marker
    super
  end

  def choose_marker
    answer = nil
    loop do
      puts "Please choose X or O as your marker:"
      answer = gets.chomp.upcase
      break if %w(X O).include?(answer)
      puts "Sorry that's not a valid choice..."
    end
    answer.upcase
  end
end
# ********************
class Computer < Player
  attr_reader :marker

  def initialize(other_marker)
    @marker = assign_marker(other_marker)
    super()
  end

  def set_name
    ['Machine Lifeform', '2B', '9S', 'Tron', 'Marvin'].sample
  end

  def assign_marker(other_marker)
    return 'O' if other_marker == 'X'
    return 'X' if other_marker == 'O'
  end
end
# ********************
class TTTGame
  WINNING_POINTS = 3

  attr_reader :board, :human, :computer, :current_marker

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new(@human.marker)
    @current_marker = first_to_move
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def clear
    system 'clear'
  end

  def game_rounds # too many lines? Extract another method? or refactor
    loop do
      display_board
      player_move
      display_result
      update_score unless tie?
      display_scoreboard
      break if won_game?
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def main_game
    loop do
      game_rounds
      break unless won_game?
      display_game_winner
      break unless play_again?
      reset
      reset_scoreboard
      display_play_again_message
    end
  end

  def tie?
    board.winning_marker.nil?
  end

  def update_score
    player = board.winning_marker == human.marker ? human : computer
    player.add_point
  end

  def first_to_move
    if pick_who_goes_first?
      player = determine_first_turn
    else
      player = %w(user computer).sample
      puts "Okay then the computer will choose #{player} to go first!"
    end
    select_marker(player)
  end

  def determine_first_turn
    answer = nil
    loop do
      puts "Who should go first the user or computer?"
      answer = gets.chomp.downcase
      break if %w(user computer).include?(answer)
      puts "Sorry but that's not a valid choice..."
    end
    answer
  end

  def select_marker(value)
    value == 'user' ? human.marker : computer.marker
  end

  def pick_who_goes_first?
    answer = nil
    loop do
      puts "Would you like to choose who goes first? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry but that's not a valid choice..."
    end
    return true if %w(y yes).include?(answer)
  end

  def display_scoreboard
    puts "SCOREBOARD:"
    puts "#{human.name}'s score => #{human.score} points"
    puts "#{computer.name}'s score => #{computer.score} points"
  end

  def won_game?
    [@human, @computer].each do |player|
      return true if player.winning_score?
    end
    false
  end

  def reset_scoreboard
    @human.reset_score
    @computer.reset_score
  end

  def display_game_winner
    if @human.winning_score?
      puts "You got #{WINNING_POINTS} points. You win!"
    elsif @computer.winning_score?
      puts "#{computer.name} got #{WINNING_POINTS} points. You lose!"
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe #{human.name}!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye."
  end

  def display_board
    puts "#{human.name} = #{human.marker}"
    puts "#{computer.name} = #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def join(array, string)
    if array.size > 1
      array[0..-2].join(', ') + ", #{string} #{array[-1]}"
    else
      array[0]
    end
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def human_moves
    numbers_available = board.unmarked_keys
    puts "Choose a square between (#{join(numbers_available, 'or')}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry that's not a valid choice"
    end
    board[square] = human.marker
  end

  def computer_defend
    square = nil
    Board::WINNING_LINES.each do |line|
      square = board.find_a_square(line, human.marker)
      break if square
    end
    square
  end

  def computer_attack
    square = nil
    Board::WINNING_LINES.each do |line|
      square = @board.find_a_square(line, computer.marker)
      break if square
    end
    square
  end

  def computer_moves
    square = computer_attack
    square = computer_defend if square.nil?
    if !square
      square = if board.unmarked_keys.include?(5)
                 5
               else
                 board.unmarked_keys.sample
               end
    end
    board[square] = @computer.marker
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, please try again..."
    end
    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = first_to_move
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
