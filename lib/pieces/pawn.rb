# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def ascii
    color == :white ? '♙' : '♟'
  end

  def possible_moves(board)
    allowed_move_directions = move_directions
    allowed_move_directions.pop if has_moved?(board)
  
    move_positions = allowed_move_directions
      .map { |direction| next_position(board.index(self), direction)}
      .select { |move| board[move].nil? }
  
    take_positions = take_directions
      .map { |direction| next_position(board.index(self), direction)}
      .compact
      .select { |new_position| board[new_position] && board[new_position].color != color}
  
    move_positions + take_positions
  end

  private

  def move_directions
    color == :black ? [[0, -1], [0, -2]] : [[0, 1], [0, 2]]
  end

  def take_directions
    color == :black ? [[-1, -1], [1, -1]] : [[-1, 1], [1, 1]]
  end
  
  def has_moved?(board)
    return false if color == :black && (48..55).include?(board.index(self))
    return false if color == :white && (8..15).include?(board.index(self))
    true
  end
end
