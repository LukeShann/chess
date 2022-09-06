# encoding: UTF-8
# frozen_string_literal: true

require_relative 'peice'

class Queen < Peice
  def initialize(_)
    super
    @ascii = ['♕', '♛']
  end
end
