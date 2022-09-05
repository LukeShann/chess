# frozen_string_literal: true

require_relative 'peice'

class Pawn < Peice
  def initialize
    @ascii = ['♙', '♟']
  end
end
