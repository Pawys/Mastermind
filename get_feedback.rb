module GetFeedback
  def check(guess,code)
    feedback = []
    unchecked_choices = code.dup
    unchecked_player_choices = guess.dup

  2.times do |number|
    unchecked_player_choices.each_with_index do |player_color, index|
        next if player_color.nil?
        if number == 0
          if player_color == unchecked_choices[index]
            feedback.push("⚫")
            unchecked_choices[index] = nil
            unchecked_player_choices[index] = nil
          end
        elsif number == 1
          if unchecked_choices.include?(player_color)
            feedback.push("⚪")
            unchecked_choices[unchecked_choices.find_index(player_color)] = nil 
            unchecked_player_choices[index] = nil
          end
        end
      end
    end
  feedback.fill("--", feedback.length...4)
  end
end
