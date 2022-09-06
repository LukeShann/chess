# -*- encoding : utf-8 -*-
# frozen_string_literal: true

require_relative 'board'
require_relative 'display'

class Game
  include Display
  @@x_axis_translation = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
  
  def initialize
    @board = Board.new
  end

  def translate_axis()
  end
end
d
end
