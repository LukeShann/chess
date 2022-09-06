# encoding: UTF-8
# frozen_string_literal: true

require_relative 'peice'

class Knight < Peice
  @@move_directions = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]

  def initialize(color, coords)
    super(color, coords)
    @ascii = ['♘', '♞']
  end

  def possible_moves(board)
    new_positions = @@move_directions.map { |move| next_coords(@coords, move)}
    filter_moves(board, new_positions - [false])
  end
end
