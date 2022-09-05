# frozen_string_literal: true

require_relative 'peice'

class Queen < Peice
  def initialize
    @ascii = ['♕', '♛']
  end
end
