# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Knight < SteppingPiece
  def ascii
    color == :white ? '♘' : '♞'
  end

  private

  def move_directions
    [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
  end
end
