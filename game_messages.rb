module GameMessages
  def display_color_infromation()
    puts "Choose one of the avaliable colors:"
    puts "Red[Rd], Yellow[Yl], Green[Gn], Blue[Bl], Purple[Pr], White[Wh]"
    puts ""
  end
  def choose_player()
    puts "Which player do you want to be?"
    puts "1: Codebreaker - You will try to break the code chosen by the codemaker."
    puts "2: Codemaker - You will create the code that the codebreaker will have to guess"
    return get_player_anwser(["1","2"],"Player Choice (1/2): ")
  end
  def display_rules()
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
  def clear()
    (system "clear") || (system "cls")
  end
  def get_player_anwser(avaliable_anwsers, message)
    print message
    player_choice = gets.chomp.downcase
    avaliable_anwsers = avaliable_anwsers.dup.map(&:downcase)
    until avaliable_anwsers.include?(player_choice)
      puts "Incorect choice"
      puts "Choose again"
      print message
      player_choice = gets.chomp
    end
    player_choice
  end
end
