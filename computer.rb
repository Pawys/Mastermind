require_relative 'get_feedback'

class Computer
  include GetFeedback
  attr_accessor :name
  def initialize(name)
  @colors = ["Rd","Yl","Gn","Bl","Pr","Wh"]
  @all_possible_codes = @colors.product(@colors, @colors, @colors)
  @s = @all_possible_codes.dup
  @guesses = 0
  @last_guess
  @name = name
  end
  def guess(last_response)
    unless last_response == nil
      @s.dup.each do |possible_code|
        @s.delete(possible_code) if check(@last_guess, possible_code) != last_response
      end
    end
    if @guesses > 0
      @last_guess = @s.sample
    else
      @last_guess = ["Rd","Rd","Yl","Yl"]
    end
    @guesses +=1
    return @last_guess
  end
  def create_code
    @all_possible_codes.sample
  end
end
