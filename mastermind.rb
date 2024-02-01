class Color
  attr_accessor :color, :placement
  def initialize(choice)
    @color = choice[0]
    @placement = choice[1]
  end
end
class PegBoard
  attr_accessor :board
  def initialize(choice)
    @board = choice
  end
end
class Gameboard
  attr_accessor :codemaker_choice
  def initialize()
    @size = 4
    @max_number_of_guesses = 12
    @guesses = 0
    @codebreaker_choices = []
    @codemaker_choice
    @code_feedback = []
    @colors = ["Rd","Yl","Gn","Bl","Pr","Wh"]
    create_codemaker_choice()
    @black_peg = Color.new(["⚫", nil])
    @white_peg = Color.new(["⚪", nil])
  end
  def print_gameboard()
    puts " ___________________    ____________________  "
    puts "|                   |  |                    | "
    puts "|    Your Guesses   |  |      Feedback      | "
    puts "|-------------------|  |--------------------| "
    @guesses.times do |num|
      puts "| #{@codebreaker_choices[num].board.map{|color| color = color.color}.join(" | ")} |  | #{@code_feedback[num].board.map{|color| color = color.color}.join(" | ")}  |"
    end
    (@max_number_of_guesses - @guesses).times do
      puts "| #{Array.new(4, "--").join(" | ")} |  | #{Array.new(4, "--").join(" | ")}  |"
    end
    puts "|___________________|  |____________________| "
  end
  def codebreaker_win?()
    return true if @code_feedback[-1].board.uniq == [@black_peg]
    false
  end
  def codemaker_win?()
    true if @guesses == @max_number_of_guesses && !codebreaker_win?()
  end
  def create_codemaker_choice()
    choices = []
    @size.times do |i|
      choices.push(Color.new([@colors[rand(6)], i]))
      p choices[i].color
    end
    @codemaker_choice = PegBoard.new(choices)
  end
  def add_codebreaker_choice(choices)
    colors = []
    choices.each do |choice|
      colors.push(Color.new(choice))
    end
    @codebreaker_choices.push(PegBoard.new(colors))
    check(@codebreaker_choices[@guesses])
    @guesses += 1
  end
  def check(player_board)
    found_array = []
    matchs = []
    partial_matchs = []
    unchecked_choices = @codemaker_choice.board.dup
    unchecked_player_choices = player_board.board.dup
    3.times do |number|
      unchecked_player_choices.each_with_index do |player_color, index|
        next if player_color == nil
        if number == 0 
          match = unchecked_choices.find { |maker_color| player_color.placement == maker_color.placement && player_color.color == maker_color.color }
          if match
            found_array.push(@black_peg)
            unchecked_choices.delete(match)
            unchecked_player_choices[index] = nil
          end
        elsif number == 1
          partial_match = unchecked_choices.find { |maker_color| player_color.color == maker_color.color }
          if partial_match
            found_array.push(@white_peg)
            unchecked_choices.delete(partial_match)
            unchecked_player_choices[index] = nil 
          end
        else
          found_array.push(Color.new(["--", nil]))
        end
      end
    end
    p found_array
    @code_feedback.push(PegBoard.new(found_array))
  end
end
class Mastermind
  def initialize()
    @size = 4
    @gameboard = Gameboard.new()
    @colors = ["Red", "Yellow", "Green", "Blue", "Purple", "White","Rd","Yl","Gn","Bl","Pr","Wh"]
    @loop = true
  end

  def draw()
    @gameboard.draw_gameboard()
  end

  def codebreaker_turn(colors)
    codebreaker_choices = []
    i = 0
    colors.each do |color|
      codebreaker_choices.push([color,i])
      i += 1
    end
    @gameboard.add_codebreaker_choice(codebreaker_choices)
  end
  def show_rules()
    puts "Would you like to review the rules? (recommended)"
    return unless gets.chomp == "y"
    system "clear"
    puts "1. Your objective as the codebreaker is to decipher the secret code crafted by the codemaker."
    puts "2. The secret code comprises four colors selected by the codemaker, allowing for duplicates. Empty spaces are not permitted."
    puts "3. To make a guess, input any combination of four colors."
    puts "4. Feedback will be provided based on your guess."
    puts "5. A black peg (⚫) is awarded when both the color and its position are correct."
    puts "6. A white peg (⚪) is awarded when only the color is accurate."
    puts ""
    puts "Example:"
    puts "Secret code: Rd Bl Gn Rd"
    puts ""
    puts "User guess: Rd Rd Gn Bl"
    puts "Feedback: ⚫⚪⚪⚪"
    puts ""
    puts "Press return to continue"
    gets
  end

  def play()
    show_rules()
    while @loop
      system "clear"
      puts "Choose one of the avaliable colors:"
      puts "Red[Rd], Yellow[Yl], Green[Gn], Blue[Bl], Purple[Pr], White[Wh]"
      puts ""
      @gameboard.print_gameboard
      puts ""
      player_chocies = []
      @size.times do |i|
        print "#{i + 1}: "
        player_choice = gets.chomp.capitalize
        while @colors.include?(player_choice) == false
          puts "Incorect choice"
          puts "Choose again"
          print "#{i + 1}: "
          player_choice = gets.chomp.capitalize
        end
        player_choice = @colors[(@colors.find_index { |element| element == player_choice }) + 6]  if player_choice.length > 2
        player_chocies.push(player_choice)
      end
      codebreaker_turn(player_chocies)
      system "clear"
      @gameboard.print_gameboard()
      puts ""
      check_result()
    end
  end

  def check_result()
    end_game("codebreaker") if @gameboard.codebreaker_win?
    end_game("codemaker") if @gameboard.codemaker_win?
  end

  def end_game(winning_player) 
    @loop = false
    puts "The #{winning_player} wins!"
    puts "The code was #{@gameboard.codemaker_choice.board.map{|color| color = color.color}.join(" ")}"
    puts ""
    puts "Do you want to play again? [y/n]"
    reset() if gets.chomp == 'y'
  end

  def reset()
    @gameboard = Gameboard.new()
    @loop = true
    play()
  end
end
game = Mastermind.new()
game.play()
