# frozen_string_literal: true

class Peice
  attr_reader :color
  def initialize(color, coords)
    @color, @coords = color, coords
  end

  def ascii
    @color == :white ? @ascii.first : @ascii.last
  end

  def can_move?
    # call individual peice's move method and ensure a length of 1 +
    # stubbed with true while testing
    true
  end
end
