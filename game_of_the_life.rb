require_relative 'cell'

matrix = File.open('input.txt').readlines

puts "incio"
puts matrix

cells = []
for y in 0...matrix.length
  for x in 0...matrix[y].length
    if matrix[y][x] == '*'
      cells.push(Cell.new(x, y))
    end
  end
end


dead_cells = Array.new

Bounds = Struct.new(:y_top, :y_bottom, :x_left, :x_right)

def get_cell_bounds(matrix, cell)
  bounds = Bounds.new(
    cell.positionY - 1, 
    cell.positionY + 1,
    cell.positionX - 1,
    cell.positionX + 1
  )
  
  if cell.positionY == 0 then bounds.y_top = 0 end
  if cell.positionY == matrix.length - 1 then bounds.y_bottom -= 1 end
  if cell.positionX == 0 then bounds.x_left = 0 end
  if cell.positionX == matrix[0].length - 1 then bounds.x_right -= 1 end
    
  return bounds
end


def count_neighbors(matrix, cell, bounds)
  for y in bounds.y_top .. bounds.y_bottom
    for x in bounds.x_left .. bounds.x_right

      # Ignora la misma casilla de la cell
      if x == cell.positionX && y == cell.positionY
        next
      end

      # Cuenta los vecinos
      if matrix[y][x] == '*'
        cell.neighbors += 1
      end
    end
  end
end


def kill_cell(matrix, cell, dead_cells)
  if(cell.neighbors < 2 || cell.neighbors > 3)
    matrix[cell.positionY][cell.positionX] = '.'
    dead_cells.push(cell)
  end
end



cells.each do |cell|
  bounds = get_cell_bounds(matrix, cell)
  count_neighbors(matrix, cell, bounds)
  kill_cell(matrix, cell, dead_cells)
end


# Eliminar celulas muertas
dead_cells.each do |cell|
  cells.delete(cell)
end
dead_cells.clear


puts cells

puts ""
puts matrix