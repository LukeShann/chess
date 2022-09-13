# frozen_string_literal: true

local_directory = File.expand_path('../../', __FILE__)
Dir["#{local_directory}/lib/pieces/*.rb"].each { |file| require file }
require_relative 'coords'

class Board
  attr_reader :state, :selected_position, :high_lighted
  include Coords

  def initialize(copied)
    @state = Array.new(8 * 8)
    fill_board unless copied
    @selected_position = nil
    @high_lighted = []
  end
  
  def validate_selection(position, current_player)
    peice = state[position]
    return :no_peice_to_select if peice.nil?
    return :choose_friendly_peice if peice.color != current_player
    return :peice_cannot_move unless peice.can_move?(state)
    true
  end

  def select(position)
    @selected_position = position
    @high_lighted = state[position].possible_moves(state)
  end

  def unselect
    @selected_position = nil
    @high_lighted.clear
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

  def king_position(color)
    state.index do |content|
      content != nil && 
      content.kind_of?(King) && 
      content.color == color
    end
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

  def copy
    copied_board = Board.new(true)
    copied_state = state.map do |content|
      if content.nil?
        nil
      else
        class_to_copy = content.class
        color_to_copy = content.color
        class_to_copy.new(color_to_copy)
      end
    end
    copied_board.set_state(copied_state)
    copied_board
  end

  def set_state(state)
    @state = state
  end

  def load_in_state(load_state)
    loaded_state = load_state.map do |hash|
      piece = nil
      unless hash.empty?
        color = hash[:color].to_sym
        piece = case hash[:class]
        when 'Rook'
          Rook.new(color)
        when 'Knight'
          Knight.new(color)
        when 'Bishop'
          Bishop.new(color)
        when 'Queen'
          Queen.new(color)
        when 'King'
          King.new(color)
        when 'Pawn'
          Pawn.new(color)
        end
      end
      piece
    end
    set_state(loaded_state)
  end

  def to_json 
    arr = @state.map do |position|
      position.nil? ? {} : {:class => position.class.to_s, :color => position.color}
    end
    arr.to_json
  end
end
