# frozen_string_literal: true

require_relative 'peice'

class Rook < Peice
  def initialize
    @ascii = ['♖', '♜']
  end
end
