# frozen_string_literal: true

local_directory = File.expand_path('../../', __FILE__)
Dir["#{local_directory}/lib/pieces/*.rb"].each { |file| require file }
require_relative 'coords'

class Board
  attr_reader :state, :selected_position, :high_lighted
  include Coords

  def initialize
    @state = Array.new(8 * 8)
    fill_board
    @selected_position = []
    @high_lighted = []
  end
  
  # Needs updating
  def check_selection(position, current_player)
    peice = state[position]
    return :no_peice_to_select if peice.nil?
    return :peice_cannot_move unless peice.can_move?(state)
    return :choose_friendly_peice if peice.color != current_player
    true
  end

  def select(position)
    @selected_position = position
    @high_lighted = state[position].possible_moves(state)
  end

  def selected_peice
    state[selected_position]
  end

  def make_move(move_to)
    state[move_to] = selected_peice
    state[selected_position] = nil
    
    @selected_position = nil
    @high_lighted.clear
  end

  def find_enemy_king(current_color)
    state.index { |x| x != nil && x.kind_of?(King) && x.color != current_color }
  end

  def fill_board
    place_peices(Rook, [0, 7, 56, 63])
    place_peices(Knight, [1, 6, 57, 62])
    place_peices(Bishop, [2, 5, 58, 61])
    place_peices(Queen, [59, 3])
    place_peices(King, [60, 4])
    place_peices(Pawn, (8..15).to_a + (48..55).to_a)
  end

  def place_peices(peice_class, positions)
    positions.each do |position|
      color = position < 16 ? :white : :black
      @state[position] = peice_class.new(color)
    end
  end
end
