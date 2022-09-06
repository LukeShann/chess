# frozen_string_literal: true

require_relative 'board'
require_relative 'display'

class Game
  include Display
  
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
      break if won
      change_turn
    end

    message(:win)
  end

  def take_turn
    message(:turn_instructions)

    # move = nil
    # loop do
    #   move = get_input
    #   break if @board.move_valid?(move)
    #   message(:invalid_turn)
    # end

    # @board.make_move(move, @current_player)
  end

  def get_input
    input = nil
    loop do
      message(:input_instructions)
      input = gets.chomp.to_i
      break if input_valid?(input)
      message(:invalid_input)
    end

    input - 1
  end
  
  def input_valid?(i)
    # letter & number
  end
end
