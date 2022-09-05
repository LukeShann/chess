# frozen_string_literal: true

require_relative 'peice'

class King < Peice
  def initialize
    @ascii = ['♔', '♚']
  end
end
