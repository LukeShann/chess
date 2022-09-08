# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  def move_directions
    [[-1, 0], [0, -1], [0, 1], [1, 0]]
  end

  def ascii
    color == :white ? '♖' : '♜'
  end
end
