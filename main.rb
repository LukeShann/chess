# frozen_string_literal: true

require_relative './lib/game'

game = Game.new
game.play

# For testing
game.display_board
