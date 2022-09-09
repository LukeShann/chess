# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Bishop < SlidingPiece
  def ascii
    color == :white ? '♗' : '♝'
  end

  private

  def move_directions
  [[-1, -1], [-1, 1], [1, -1], [1, 1]]
  end
end
