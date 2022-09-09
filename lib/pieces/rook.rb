# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Rook < SlidingPiece
  def ascii
    color == :white ? '♖' : '♜'
  end

  private

  def move_directions
    [[-1, 0], [0, -1], [0, 1], [1, 0]]
  end
end
