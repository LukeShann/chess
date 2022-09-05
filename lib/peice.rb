# frozen_string_literal: true

class Peice
  def initialize(player)
    @player = player
    @color = player == 1 ? :black : :white
  end
end
