# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  @@move_directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  def initialize(color, coords)
    super(color, coords)
    @ascii = ['♔', '♚']
  end

  def possible_moves(board)
    new_positions = @@move_directions
    .map { |move| next_coords(@coords, move)}
    .reject(&:nil?)
    
  #TODO: filter out moves that would put king in check
  filter_moves(board, new_positions)
  end
end
