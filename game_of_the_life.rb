require_relative 'celula'

input = File.open('input.txt').readlines

puts "incio"
puts input

celulas = []
for i in 0...input.length
  for j in 0...input[i].length
    if input[i][j] == '*'
      celulas.push(Celula.new(i, j))
    end
  end
end
puts celulas.length
celulas.each do |celula|
  for i in celula.posicionX-1 .. celula.posicionX+1
    for j in celula.posicionY-1 .. celula.posicionY+1
      if i == celula.posicionX && j == celula.posicionY
        next
      end

      if i < 0 || j < 0 || i >= input.length || j >= input[i].length
        puts "pos"
        puts celula.posicionX, celula.posicionY
        puts ""
        next
      end

      if input[i][j] == '*'
        celula.vecinos += 1
      end
    end
  end
  if(celula.vecinos < 2 || celula.vecinos > 3)
    input[celula.posicionX][celula.posicionY] = '.'
    puts "Celula eliminada"
    puts "Posicion: #{celula.posicionX}, #{celula.posicionY}"
    celulas.delete(celula) 
  end
end

puts input

celulas.each do |celula|

end