# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def initialize(color, coords)
    super(color, coords)
    @ascii = ['♙', '♟']
    @is_first_move = true
  end

  def possible_moves(board)

    # from Knight:
    # new_positions = @move_directions.map { |move| next_coords(@coords, move)}
    # filter_moves(board, new_positions
  end

  def move()
    # is_first_move to false
  end
end
