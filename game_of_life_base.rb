# frozen_string_literal: true

# Clase que genera las siguientes generaciones del juego de la vida
# basandose en una primer grid que representa la 1er generación.
class GameOfLife
  attr_accessor :width, :height, :matrix, :grid

  def initialize(width = nil, height = nil, char_dead_cell = nil, char_live_cell = nil)
    @matrix = File.open('input.txt').readlines
    grid_size = @matrix[1].split(' ')
    @width = grid_size.empty? ? width : grid_size[0].to_i
    @height = grid_size.empty? ? height : grid_size[1].to_i
    @char_dead_cell = char_dead_cell.nil? ? '.' : char_dead_cell
    @char_live_cell = char_live_cell.nil? ? '*' : char_live_cell
    @grid = nil
  end

  # Definir celulas muertas como false y celulas vivas como True
  def create_grid
    # Definimos el height y el width del grid y todas las celdas estan como False
    @grid = Array.new(@height) { Array.new(@width, false) }

    # Si el archivo .txt encuentro un asterisco (*) Lo marco como true
    @height.times do |axis_y|
      @width.times do |axis_x|
        @grid[axis_y][axis_x] = true if matrix[axis_y + 2][axis_x] == '*'
      end
    end
  end

  # Imprimo el grid. Si esta false es un punto '.' si es true es un '*'
  def show_grid
    @height.times do |axis_y|
      @width.times do |axis_x|
        print @grid[axis_y][axis_x] ? @char_live_cell : @char_dead_cell
      end
      puts
    end
  end

  def count_live_neighbours(axis_x, axis_y)
    live_neighbours = 0
    (-1..1).each do |cur_y|
      (-1..1).each do |cur_x|
        # Saltar la célula actual
        next if cur_y.zero? && cur_x.zero?

        # Mira los vecinos a su alrededor
        neighbour_x = (axis_x + cur_x + @width) % @width
        neighbour_y = (axis_y + cur_y + @height) % @height

        # Cuenta Si alrededor hay una célula viva (true)
        live_neighbours += 1 if @grid[neighbour_y][neighbour_x]
      end
    end
    live_neighbours
  end

  def update_new_grid(new_grid, axis_y, axis_x, live_neighbours)
    if @grid[axis_y][axis_x] && [2, 3].include?(live_neighbours)
      new_grid[axis_y][axis_x] = true
    elsif !@grid[axis_y][axis_x] && (live_neighbours == 3)
      new_grid[axis_y][axis_x] = true
    end
  end

  def next_generation
    new_grid = Array.new(@height) { Array.new(@width, false) }
    @height.times do |axis_y|
      @width.times do |axis_x|
        live_neighbours = count_live_neighbours(axis_x, axis_y)
        update_new_grid(new_grid, axis_y, axis_x, live_neighbours)
      end
    end
    @grid = new_grid
  end

  def loop(repetitions)
    create_grid
    repetitions.times do
      show_grid
      sleep(1)
      system('clear') || system('cls')
      next_generation
    end
  end
end
