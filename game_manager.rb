require_relative 'game_messages'
require_relative 'mastermind'
class GameManager
  include GameMessages
  def initialize
    @game
  end
  def start()
    player_choice = get_player_anwser(["y","n"],"Do you want to review to rules?(y/n): ")
    display_rules() if player_choice == "y"
    clear()
    player_choice = get_player_anwser(["y","n"],"Does your terminal correctly show these emojis '⚫,⚪'(it should be a black and a white circle)?(y/n): ")
    clear()
    loop = 1
    while loop == 1
      @game = Mastermind.new(player_choice)
      @game.play
      player_choice = get_player_anwser(["y","n"],"Do you want to play again?(y/n): ")
      loop = 0 if player_choice == "n"
      clear()
    end
  end
end
