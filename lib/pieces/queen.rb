# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  @@move_directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  
  def initialize(color, coords)
    super(color, coords)
    @ascii = ['♕', '♛']
  end

  def move_directions
    @@move_directions
  end
end
