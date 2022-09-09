# frozen_string_literal: true

require_relative 'board'
require_relative 'display'
require_relative 'coords'

class Game
  include Display
  include Coords

  X_AXIS = 'ABCDEFGH'
  
  def initialize
    @board = Board.new
    @current_player_color = :white
    @in_check = false
  end

  def play
    message(:welcome, true)
    
    loop do
      take_turn
      in_check?
      #   break if stale_mate
      change_turn
    end
    # message(:win)
  end

  def in_check?
    enemy_king_coords = @board.find_enemy_king(@current_player_color)
    @board.state.any? do |x|
      unless x.nil? || x.color != @current_player_color
        if x.possible_moves(@board.state).include?(enemy_king_coords)
          @in_check = true
        end
      end
    end
  end

  def take_turn
    select_peice
    # TODO: offer to cancel

    move = nil
    loop do
      message(:make_move, false)
      move = get_input
      break if @board.high_lighted.include?(move)
      # TODO: ensure we get out of check
      message(:cannot_move_there, true)
    end

    @board.make_move(move)
  end

  def change_turn
    @current_player_color = @current_player_color == :black ? :white : :black
  end

  def select_peice
    message(:turn_instructions, false)
    selection = nil
    loop do
      selection = get_input
      response = @board.check_player_choice(selection, @current_player_color)
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
    translate_coord([x, y])
  end
end
