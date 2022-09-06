# encoding: UTF-8
# frozen_string_literal: true

require_relative 'peice'

class Bishop < Peice
  def initialize(color, coords)
    super(color, coords)
    @ascii = ['♗', '♝']
  end
end
