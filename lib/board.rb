# frozen_string_literal: true

require_relative 'peice'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  private

  def fill_board
    @board.map!
  end
end
