# frozen_string_literal: true

class Peice
  attr_reader :color
  def initialize(color, coords)
    @color, @coords = color, coords
  end

  def ascii
    @color == :white ? @ascii.first : @ascii.last
  end

  def can_move?(board)
    possible_moves(board).length > 0
  end

  def next_coords(coords, movement)
    nx = coords.first + movement.first
    return false unless (0..7).include?(nx)
    ny = coords.last + movement.last
    return false unless (0..7).include?(ny)
    [nx, ny]
  end

  def filter_moves(board, moves)
    moves.filter do |move|
      target = board[move.first][move.last]
      target.nil? || target.color != @color ? move : false
    end
  end
end
