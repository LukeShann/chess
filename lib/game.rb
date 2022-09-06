# frozen_string_literal: true

require_relative 'board'
require_relative 'display'


class Game
  include Display
  X_AXIS = 'ABCDEFGH'
  
  def initialize
    @board = Board.new
    @current_player = :white
  end

  def change_turn
    @current_player = @current_player == :black ? :white : :black
  end

  def play
    message(:welcome)

    loop do
      take_turn
    #   break if won
    #   change_turn
    end

    # message(:win)
  end

  def take_turn
    select_peice
    # message which peice is selected
    # offer to cancel
    # highlight selected tile
    # highlight legal moves

    # loop
      # prompt for next input
      # break if is included in 'legal moves'
      
    #  break if selection is of current players colour
    #   message(:invalid_turn)
    #end

    # @board.make_move(move, @current_player)
  end

  def select_peice
    message(:turn_instructions)
    selection = nil
    loop do
      selection = get_input
      break if @board.valid_selection?(selection, @current_player)
      message(:not_friendly_peice)
    end
    selection
  end

  def get_input
    input = nil
    loop do
      message(:input_instructions)
      input = gets.chomp
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
    [x, y]
  end
end
