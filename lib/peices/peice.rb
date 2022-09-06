# -*- encoding : utf-8 -*-
# frozen_string_literal: true

class Peice
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def ascii
    @color == :white ? @ascii.first : @ascii.last
  end
end
