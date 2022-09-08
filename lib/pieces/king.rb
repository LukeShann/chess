# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  def move_directions
    [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end
  
  def ascii 
    color == :white ? '♔' : '♚'
  end
  
  def possible_moves(board)
    possible_moves_static(board)
  end
end
