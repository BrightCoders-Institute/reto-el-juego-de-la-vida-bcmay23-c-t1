# frozen_string_literal: true

# Clase que genera las siguientes generaciones del juego de la vida
# basandose en una primer grid que representa la 1er generación.
class GameOfLife
    attr_accessor :width, :height, :matrix

  def initialize(width=nil, height=nil, char_dead_cell=nil, char_live_cell=nil)    
    @matrix = File.open('input.txt').readlines
    grid_size = @matrix[1].split(' ')
    @width = grid_size.empty? ? width : grid_size[0].to_i
    @height = grid_size.empty? ? height : grid_size[1].to_i
    @char_dead_cell = char_dead_cell.nil? ? '.' : char_dead_cell
    @char_live_cell = char_live_cell.nil? ? '*' : char_live_cell
    # @char_live_cell = '*'
  end

  # TODO : Hacer que acepte las dimeciones "custom"
  # fallan al crear grid

  # Definir celulas muertas como false y celulas vivas como True
  def create_grid
    # Definimos el height y el width del grid y todas las celdas estan como False
    @grid = Array.new(@width) { Array.new(@height, false) }
    @matrix = File.open('input.txt').readlines

    # Si el archivo .txt encuentro un asterisco (*) Lo marco como true
    @matrix.each_with_index do |row, y|
      row.split('').each_with_index do |column, x|
        @grid[y - 2][x] = true if column == '*'
      end
    end
  end

  # Imprimo el grid. Si esta false es un punto '.' si es true es un '*'
  def show_grid
    @width.times do |i|
      @height.times do |j|
        print @grid[i][j] ? @char_live_cell : @char_dead_cell
      end
      puts
    end
  end

  def count_live_neighbours(axis_x, axis_y)
    live_neighbours = 0
    (-1..1).each do |i|
      (-1..1).each do |j|
        # Saltar la célula actual
        next if i.zero? && j.zero?

        # Mira los vecinos a su alrededor
        neighbour_x = (axis_x + i + @width) % @width
        neighbour_y = (axis_y + j + @height) % @height

        # Cuenta Si alrededor hay una célula viva (true)
        live_neighbours += 1 if @grid[neighbour_x][neighbour_y]
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
    new_grid = Array.new(@width) { Array.new(@height, false) }
    @width.times do |axis_y|
      @height.times do |axis_x|
        live_neighbours = count_live_neighbours(axis_y, axis_x)
        update_new_grid(new_grid, axis_y, axis_x, live_neighbours)
      end
    end
    @grid = new_grid
  end

  def loop
    self.create_grid
    50.times do
      system('clear') || system('cls')
      self.next_generation
      self.show_grid
      sleep(0.5)
    end
  end

end
