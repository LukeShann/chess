# frozen_string_literal: true

class Peice
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def ascii
    @color == :white ? @acsii.first : @acsii.last
  end
end
