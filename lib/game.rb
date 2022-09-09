# frozen_string_literal: true

require_relative 'board'
require_relative 'display'
require_relative 'coords'

class Game
  include Display
  include Coords

  X_AXIS = 'ABCDEFGH'
  
  def initialize
    @board = Board.new(false)
    @current_player_color = :white
    @in_check = false
  end

  def play
    message(:welcome, true)
    loop do
      take_turn
      has_check?(@board, @current_player_color)
      break if has_check_mate?(@board, @current_player_color)
      change_turn
    end
    message(:check_mate, true)
  end

  def has_check?(board, color)
    enemy_king_position = board.king_position(opposite_color(color))
    board.state.any? do |content|
      if is_friendly_piece(content, color) && content.threatens_king?(board.state, enemy_king_position)
          @in_check = true
      end
    end
  end

  def has_check_mate?(board, color)
    return false unless @in_check

    check_mate = true
    enemy_pieces = board.state.select { |content| is_enemy_piece?(content, color)}
    check_mate = false if enemy_pieces.any? do |piece|
      moves = piece.possible_moves(board.state)
      moves.any? { |move| moves_out_of_check?(board, piece, move) }
    end
    check_mate
  end

  def moves_out_of_check?(board, piece, move)
    position = board.state.index(piece)
    board_copy = board.copy
    board_copy.select(position)
    board_copy.make_move(move)
    !has_check?(board_copy, opposite_color(piece.color))
  end

  def threatens_king?(board, enemy_king_position)
    possible_moves(board).include?(enemy_king_position)
  end

  def is_friendly_piece(piece, color)
    piece && piece.color == color
  end

  def is_enemy_piece?(piece, your_color)
    piece && piece.color != your_color
  end

  def opposite_color(color)
    color == :white ? :black : :white
  end

  def take_turn
    select_peice
    # TODO: offer to cancel

    move = nil
    loop do
      message(:make_move, false)
      move = get_input
      unless @board.high_lighted.include?(move)
        message(:cannot_move_there, true)
        next
      end
      unless moves_out_of_check?(@board, @board.selected_peice, move)
        message(:exposing_king, true)
        next
      end
      break
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
