# frozen_string_literal: true

require_relative 'board'
require_relative 'display'

class Game
  include Display
  
  def initialize
    @board = Board.new
  end
end
