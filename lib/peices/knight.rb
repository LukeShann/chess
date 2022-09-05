# frozen_string_literal: true

require_relative 'peice'

class Knight < Peice
  def initialize(_)
    super
    @ascii = ['♘', '♞']
  end
end
