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
  def initialize()
    @size = 4
    @max_number_of_guesses = 12
    @guesses = 0
    @codebreaker_choices = []
    @codemaker_choice
    @code_feedback = []
    @colors = ["Red", "Yellow", "Green", "Blue", "Purple", "White"]
    create_codemaker_choice()
  end
  def print_code_feedback()
    last_guess_feedback = @code_feedback[@guesses - 1].board 
    i = 0
    last_guess_feedback.each do |color|
      i += 1 if color.color == "Black"
      puts "R: #{color.color}"
    end
    return "won" if i == @size
    "lost" if @code_feedback.length == @max_number_of_guesses
  end
  def create_codemaker_choice()
    choices = []
    @size.times do |i|
      choices.push(Color.new([@colors[rand(6)], i]))
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
    unchecked_choices = @codemaker_choice.board.dup
    player_board.board.each do |player_color|
      unchecked_choices.each do |maker_color|
        if player_color.placement == maker_color.placement && player_color.color == maker_color.color
            found_array.push(Color.new(["Black",nil]))
            unchecked_choices.delete(maker_color)
            break
            puts "thing delated code maker is #{@codemaker_choice.board}"
          end
        end
      end
    player_board.board.each do |player_color|
      unchecked_choices.each do |maker_color|
        if player_color.color == maker_color.color
            found_array.push(Color.new(["White",nil]))
            unchecked_choices.delete(maker_color)
            break
          end
        end
      end
    
    @code_feedback.push(PegBoard.new(found_array))
  end
end
class Mastermind
  def initialize()
    @size = 4
    @gameboard = Gameboard.new()
    @colors = ["Red", "Yellow", "Green", "Blue", "Purple", "White"]
    @result
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
  def play()
    until @result == "won" || @result == "lost"
      puts "Choose one of the avaliable colors"
      puts "Red, Yellow, Green, Blue, Purple, White"
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
        player_chocies.push(player_choice)
      end
      codebreaker_turn(player_chocies)
      puts ""
      puts "The rating of your choices:"
      case @gameboard.print_code_feedback()
      when "won"
        @result = "won"
      when "lost"
        @result = "lost"
      end
      puts ""
    end
    puts "The Codebraker Wins!" if @result == "won"
    puts "The Codemaker Wins!" if @result == "lost"
    puts ""
    puts "Do you want to play again? [y/n]"
    reset() if gets.chomp == 'y'
  end
  def reset()
    system "clear"
    @result = false
    @gameboard = Gameboard.new
    play()
  end
end
game = Mastermind.new()
game.play()
