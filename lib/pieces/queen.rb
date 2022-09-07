# encoding: UTF-8
# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  def initialize(color, coords)
    super(color, coords)
    @ascii = ['♕', '♛']
  end
end
