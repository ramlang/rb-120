# Keeping score

# Right now, the game doesn't have very much dramatic flair. It'll be more interesting if we were playing up to, say, 10 points. Whoever reaches 10 points first wins. Can you build this functionality? We have a new noun -- a score. Is that a new class, or a state of an existing class? You can explore both options and see which one works better.

# Add Lizard and Spock

# This is a variation on the normal Rock Paper Scissors game by adding two more options - Lizard and Spock. The full explanation and rules are here.

# Add a class for each move

# What would happen if we went even further and introduced 5 more classes, one for each move: Rock, Paper, Scissors, Lizard, and Spock. How would the code change? Can you make it work? After you're done, can you talk about whether this was a good design decision? What are the pros/cons?

# Keep track of a history of moves

# As long as the user doesn't quit, keep track of a history of moves by both the human and computer. What data structure will you reach for? Will you use a new class, or an existing class? What will the display output look like?

# Computer personalities

# We have a list of robot names for our Computer class, but other than the name, there's really nothing different about each of them. It'd be interesting to explore how to build different personalities for each robot. For example, R2D2 can always choose "rock". Or, "Hal" can have a very high tendency to choose "scissors", and rarely "rock", but never "paper". You can come up with the rules or personalities for each robot. How would you approach a feature like this?
require 'pry'
class Message
  attr_reader :string
  
  def initialize(string)
    @string = string
    @length = string.size  # need to fix: for two line text the length is total combined
  end
  
  def star_border
    "*" * @length
  end 
  
  def banner
    puts star_border
    puts @string
    puts star_border
  end
  
  def ask_user
    puts "=> #{string}\n"
  end
  
  def error
    puts "*** #{string.upcase} ***"
  end
end

class Player
  attr_accessor :name, :move
  
  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      Message.new("Enter your name to continue...").ask_user
      n = gets.chomp
      break unless n.empty?
      Message.new("Sorry, please try again.").error
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      text = "Please choose rock, paper, scissors, lizard, or spock..."
      Message.new(text).ask_user
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      Message.new("Sorry, please try again.").error
    end
    self.move = Move.new(choice) # instance variable 'move' defined and assigned to a Move object which has it's own methods (initialize, rock?, <, >)
  end
end

class Computer < Player
  def set_name
    self.name = ['Machine Lifeform', '2B', '9S', 'Tron', 'Marvin'].sample
  end
  
  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Scoreboard
  POINTS_TO_WIN = 10
  attr_accessor :game_score
  
  def initialize(player1, player2)
    @game_score = {player1 => 0, player2 => 0}
  end

  def update(player)
    self.game_score[player] += 1
  end
  
  def winner?
    self.game_score.values.include?(POINTS_TO_WIN)
  end

  def game_winner
    self.game_score.key(POINTS_TO_WIN)
  end
end

class Rock


class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  

end

class RPSGame
  
  attr_accessor :human, :computer, :points

  def initialize
    @human = Human.new
    @computer = Computer.new
    @points = Scoreboard.new(human.name, computer.name)
  end

  def display_greeting
    Message.new("Welcome to Rock, Paper, Scissors, Lizard, Spock!").banner
  end

  def display_goodbye
    Message.new("Thanks for playing. Goodbye!").banner
  end
  
  def display_moves
    action = "#{human.name} chose #{human.move}...\n" +
         "#{computer.name} chose #{computer.move}..."
    Message.new(action).banner
  end
  
  def display_winner
     puts" #{human.name} #{human.move.compare(computer.move.player_move)}"

  end

  def play_again?
    answer = nil
    loop do
      Message.new("Would you like to play again?").ask_user
      answer = gets.chomp
      break if ['yes', 'y', 'no', 'n'].include?(answer.downcase)
      Message.new("Please answer yes or no.").error
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_greeting # complete
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
        #update_score
      break unless play_again?
    end
    display_goodbye  # complete
  end
end

RPSGame.new.play