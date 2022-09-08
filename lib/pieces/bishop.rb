# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
   def move_directions
    [[-1, -1], [-1, 1], [1, -1], [1, 1]]
   end

  def ascii
    color == :white ? '♗' : '♝'
  end
end
