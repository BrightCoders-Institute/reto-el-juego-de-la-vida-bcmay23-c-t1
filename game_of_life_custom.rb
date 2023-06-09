# frozen_string_literal: true

require_relative 'game_of_life_base'

# Clase hija de GameOfLife que genera las siguientes generaciones del juego de la vida
# Su grid es más amplio
class GameOfLifeCustom < GameOfLife
  def initialize(*args)
    super
  end

  def show_grid
    @width.times do |i|
      @height.times do |j|
        print @grid[i][j] ? "#{@char_live_cell}  " : "#{@char_dead_cell}  "
      end
      puts
    end
  end
end
