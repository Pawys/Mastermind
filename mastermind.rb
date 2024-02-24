require_relative 'get_feedback'
require_relative 'game_messages'
require_relative 'player'
require_relative 'computer'

class Mastermind
  include GetFeedback
  include GameMessages
  def initialize
    @colors = ["Rd","Yl","Gn","Bl","Pr","Wh"]
    @code
    @code_feedback = Array.new()
    @codebreaker_guesses = Array.new()
    @codebreaker 
    @codemaker
    @guesses = 0
    @max_gueses = 12
    @winning_player
  end
  def play()
    assign_player()
    clear()
    @code = @codemaker.create_code
    while @winning_player.nil?
      clear()
      display_board()
      if @codebreaker.name == "Computer"
        print "The computer is guessing."
        sleep(0.5)
        print "."
        sleep(0.5)
        print "."
        sleep(0.5)
      end
      guess = @codebreaker.guess(@code_feedback[@guesses - 1]) if @guesses > 0
      guess = @codebreaker.guess(nil) if @guesses == 0
      feedback = check(guess,@code)
      @codebreaker_guesses.push(guess)
      @code_feedback.push(feedback)
      @guesses += 1
      check_result()
      puts  ""
    end
      clear()
      display_board()
      end_game()
  end
  def check_result()
    @winning_player = @codebreaker if @code_feedback[@guesses - 1].uniq == ["⚫"]
    @winning_player = @codemaker if @guesses >= @max_gueses
  end
  def end_game()
    if @winning_player == @codebreaker
      puts "The Codebreaker Managed To Guess The Code!"
      puts "The #{@codebreaker.name} Wins!"
      puts "It Took #{@guesses} Turns."
    else
      puts "The Codebreaker Failed To Guess the Code!"
      puts "The #{@codemaker.name} Wins!"
    end
    puts "The Code Was: #{@code.join(', ')} "
  end
  def assign_player()
    player_choice = choose_player().to_i
    if player_choice == 1
      @codebreaker = Player.new("Player") 
      @codemaker = Computer.new("Computer")
    else
      @codemaker = Player.new("Player") 
      @codebreaker = Computer.new("Computer")
    end
  end
  def display_board()
    puts " ___________________    ____________________  "
    puts "|                   |  |                    | "
    puts "|    Your Guesses   |  |      Feedback      | "
    puts "|-------------------|  |--------------------| "
    @guesses.times do |num|
      puts "| #{@codebreaker_guesses[num].join(" | ")} |  | #{@code_feedback[num].join(" | ")}  |"
    end
    (@max_gueses - @guesses).times do
      puts "| #{Array.new(4, "--").join(" | ")} |  | #{Array.new(4, "--").join(" | ")}  |"
    end
    puts "|___________________|  |____________________| "
    puts ""
  end
end
