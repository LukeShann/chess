# frozen_string_literal: true

class Piece
  attr_reader :color, :coords

  def initialize(color, coords)
    @color, @coords = color, coords
  end

  def ascii
    @color == :white ? @ascii.first : @ascii.last
  end

  def can_move?(board)
    possible_moves(board).length > 0
  end

  def move_coords(coords)
    @coords = coords
  end

  def next_coords(coords, movement)
    nx = coords.first + movement.first
    return nil unless (0..7).include?(nx)
    ny = coords.last + movement.last
    return nil unless (0..7).include?(ny)
    [nx, ny]
  end

  def filter_moves(board, moves)
    moves.filter do |move|
      target = board[move.first][move.last]
      target.nil? || target.color != @color ? move : false
    end
  end

  def path_recursive(board, positon, direction)
    new_coords = next_coords(positon, direction)
    return [] if new_coords.nil?

    next_contents = board[new_coords.first][new_coords.last]
    return [new_coords] + path_recursive(board, new_coords, direction) if next_contents.nil?
    
    return [] if next_contents.color == color
    return [new_coords] if next_contents.color != color
  end

  def possible_moves(board)
    move_directions.reduce([]) do |arr, direction|
      arr + path_recursive(board, @coords, direction)
    end
  end
end
