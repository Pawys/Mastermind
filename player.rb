require_relative 'game_messages'
class Player
  include GameMessages
  attr_accessor :name
  def initialize(name)
    @name = name
    @colors = ["Rd","Yl","Gn","Bl","Pr","Wh"]
    @colors_long = ["Red", "Yellow", "Green", "Blue", "Purple", "White"]
  end
  def guess(a)
    display_color_infromation()
    guess = []
    4.times do |i|
      player_choice = get_player_anwser(@colors.concat(@colors_long),"#{i + 1}: ")
      player_choice = @colors[@colors_long.find_index(player_choice)] if player_choice.length > 2
      guess.push(player_choice.capitalize)
      end
    guess
  end
  def create_code()
    guess(nil)
  end
end
