# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def move_directions
    [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
  end

  def ascii
    color == :white ? '♘' : '♞'
  end

  def possible_moves(board)
    possible_moves_static(board)
  end
end
