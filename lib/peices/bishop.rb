# frozen_string_literal: true

require_relative 'peice'

class Bishop < Peice
  def initialize
    @ascii = ['♗', '♝']
  end
end
