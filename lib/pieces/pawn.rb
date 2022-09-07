# frozen_string_literal: true
# encoding: UTF-8

require_relative 'piece'

class Pawn < Piece
  def initialize(color, coords)
    super(color, coords)
    @ascii = ['♙', '♟']
    if color == :black
      @move_directions = [[0, -1], [0, -2]]
      @take_directions = [[-1, -1], [1, -1]]
    else
      @move_directions = [[0, 1], [0, 2]]
      @take_directions = [[-1, 1], [1, 1]]
    end
  end

  def possible_moves(board)
    move_positions = @move_directions \
      .map { |move| next_coords(@coords, move)} \
      .select { |move| board[move.first][move.last].nil? }

    take_positions = @take_directions \
      .map { |move| next_coords(@coords, move)} \
      .reject { |move| board[move.first][move.last].nil? }

    move_positions + take_positions
  end

  def move_coords(coords)
    super(coords)
    @move_directions.pop if @move_directions.size > 1
  end
end
