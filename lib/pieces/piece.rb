# frozen_string_literal: true

require_relative '../coords'

class Piece
  attr_reader :color
  include Coords

  def initialize(color)
    @color = color
  end

  def can_move?(board)
    possible_moves(board).length > 0
  end
  
  def threatens_king?(board, enemy_king_position)
    possible_moves(board).include?(enemy_king_position)
  end

  private

  def next_position(position, movement)
    coords = translate_position(position)

    nx = coords.first + movement.first
    return nil unless (0..7).include?(nx)
    ny = coords.last + movement.last
    return nil unless (0..7).include?(ny)
    
    translate_coord([nx, ny])
  end

  def filter_moves(board, new_positions)
    new_positions.filter do |position|
      content = board[position]
      content.nil? || content.color != @color
    end
  end
end

class SlidingPiece < Piece
  def possible_moves(board)
    move_directions.reduce([]) do |arr, direction|
      arr + path_recursive(board, board.index(self), direction)
    end
  end

  private

  def path_recursive(board, positon, direction)
    new_position = next_position(positon, direction)
    return [] if new_position.nil?

    next_contents = board[new_position]
    return [new_position] + path_recursive(board, new_position, direction) if next_contents.nil?
    
    return [] if next_contents.color == color
    return [new_position] if next_contents.color != color
  end
end

class SteppingPiece < Piece
  def possible_moves(board)
    board_position = board.index(self)
    
    new_positions = move_directions
      .map { |movement| next_position(board_position, movement)}
      .reject(&:nil?)
    filter_moves(board, new_positions)
  end
end
