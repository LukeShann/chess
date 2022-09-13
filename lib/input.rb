# frozen_string_literal: true

module Input
  X_AXIS = 'ABCDEFGH'
  
  def get_input
    input = nil
    loop do
      message(:input_instructions)
      input = gets.chomp.upcase
      return input if @commands.include?(input) 
      break if input_valid?(input)
      message(:invalid_input)
    end
    translate_input(input)
  end
  
  def input_valid?(i)
    return false unless i.length == 2
    i.scan(/[A-H]/i).size == 1 && i.scan(/[1-8]/).size == 1
  end

  def translate_input(input)
    input = input.upcase
    x = X_AXIS.index(input.scan(/[A-H]/).first)
    y = input.scan(/[1-8]/).first.to_i - 1
    translate_coord([x, y])
  end
end