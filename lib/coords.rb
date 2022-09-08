# frozen_string_literal: true

module Coords
  def translate_coord(coord)
    coord.last * 8 + coord.first
  end

  def translate_coords(arr)
    arr.map { |coord| translate_coord(coord) }
  end

  def translate_position(position)
    [position % 8, position / 8]
  end
end