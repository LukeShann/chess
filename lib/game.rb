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
    message(:welcome, true)

    loop do
      take_turn
    #   break if check_mate
    #   break if stale_mate
      change_turn
    end

    # message(:win)
  end

  def take_turn
    select_peice
    # offer to cancel

    move = nil
    loop do
      message(:make_move, false)
      move = get_input
      break if @board.high_lighted.include?(move)
      message(:cannot_move_there, true)
    end

    @board.make_move(move)
  end

  def select_peice
    message(:turn_instructions, false)
    selection = nil
    loop do
      selection = get_input
      response = @board.check_selection(selection, @current_player)
      break if response == true
      message(response, true)
    end
    @board.select(selection)
  end

  def get_input
    input = nil
    loop do
      message(:input_instructions, false)
      input = gets.chomp
      break if input_valid?(input)
      message(:invalid_input, true)
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
