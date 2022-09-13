# frozen_string_literal: true

require_relative 'board'
require_relative 'display'
require_relative 'coords'
require_relative 'input'
require_relative 'memory'
require 'JSON'

class Game
  include Display
  include Coords
  include Input
  include Memory
  
  def initialize
    @board = Board.new(false)
    @current_player_color = :white
    @in_check = false
    @commands = ['X', 'S', 'L']
  end

  def play
    refresh_board
    message(:welcome)
    loop do
      message(:in_check) if @in_check
      take_turn
      refresh_board
      @in_check = has_check?(@board, @current_player_color)
      break if has_check_mate?(@board, @current_player_color)
      change_turn
    end
    message(:check_mate)
  end

  def take_turn
    move = nil
    until move
      select_piece
      refresh_board
      move = select_move
    end
    @board.make_move(move)
  end

  def select_piece
    input = nil 
    message(:save_load_menu)
    message(:turn_instructions)
    loop do
      input = get_input
      if @commands.include?(input)
        handle_command(input)
        next
      end
      validity = @board.validate_selection(input, @current_player_color)
      break if validity == true
      message(validity)
    end
    @board.select(input)
  end

  def select_move
    message(:unselect)
    message(:make_move)

    loop do
      input = get_input
      if @commands.include?(input)
        handle_command(input)
        return nil
      end
      unless @board.high_lighted.include?(input)
        message(:cannot_move_there)
        next
      end
      unless moves_out_of_check?(@board, @board.selected_peice, input)
        message(:exposing_king)
        next
      end
      return input
    end
  end

  def handle_command(command)
    case command
    when 'X'
      @board.unselect
      refresh_board
      message(:unselected)
    when 'S'
      save_game
      refresh_board
      message(:game_saved)
      exit
    when 'L'
      if File.exist?(save_path)
        load_game
        refresh_board
        message(:game_loaded)
        message(:turn_instructions)
      else
        message(:no_save_file)
      end
    else
      raise 'Command unknown'
    end
  end

  def has_check?(board, color)
    enemy_king_position = board.king_position(opposite_color(color))
    board.state.any? do |content|
      is_friendly_piece(content, color) && content.threatens_king?(board.state, enemy_king_position)
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

  private

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

  def change_turn
    @current_player_color = @current_player_color == :black ? :white : :black
  end
end
