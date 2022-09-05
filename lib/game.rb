# frozen_string_literal: true

require_relative 'board'

class Game
  def initialize
    @board = Board.new
  end
end
