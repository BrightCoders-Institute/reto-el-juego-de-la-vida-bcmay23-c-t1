class JuegoDeLaVida
    def initialize( )
        matriz = File.open('input.txt').readlines
        tamañoTablero= matriz[1].split(" ")
        @ancho = tamañoTablero[0].to_i
        @alto = tamañoTablero[1].to_i     
    end
  
    #Definir celulas muertas como false y celulas vivas como True
    def creacionTablero
        # Definimos el alto y el ancho del tablero y todas las celdas estan como False
        @tablero = Array.new(@ancho) { Array.new(@alto, false) } 
        matriz = File.open('input.txt').readlines

        #Si el archivo .txt encuentro un asterisco (*) Lo marco como true
        for y in 0...matriz.length
            for x in 0...matriz[y].length
              if matriz[y][x] == '*'
                @tablero[y-2][x] = true
              end
            end
        end
       # puts "#{@tablero}"
    end

    #Imprimo el tablero. Si esta false es un punto '.' si es true es un '*'
    def mostrarTablero
        @ancho.times do |i|
            @alto.times do |j|
                print @tablero[i][j] ? '*' : '.'
            end
            puts
        end
    end

    def contar_vecinos_vivos(x,y)
        vecinos_vivos = 0
       # puts "#{@tablero[x][y]}"
        (-1..1).each do |i|
            (-1..1).each do |j|

                # Saltar la célula actual
                if (i == 0 && j == 0)
                    next 
                end

                #Mira los vecinos a su alrededor 
                vecinoX = (x + i + @ancho) % @ancho
                vecinoY = (y + j + @alto) % @alto

                #Cuenta Si alrededor hay una célula viva (true)
                if @tablero[vecinoX][vecinoY]
                    vecinos_vivos += 1
                    #puts "Celula viva en #{vecinoX} #{vecinoY}"
                end
                #puts " en x #{vecinoX}  en Y #{vecinoY}"
            end
            #puts "vecinos_vivos: #{vecinos_vivos} "            
        end
        vecinos_vivos
    end


    def siguienteGeneracion
        nuevoTablero =  Array.new(@ancho) { Array.new(@alto, false) } 
        @ancho.times do |i|
            @alto.times do |j|
                cantidadVecinosVivos = contar_vecinos_vivos(i, j)
                    if @tablero[i][j] && (cantidadVecinosVivos == 2 || cantidadVecinosVivos == 3)
                        nuevoTablero[i][j] = true
                    

                    elsif !@tablero[i][j] && (cantidadVecinosVivos == 3 )
                        nuevoTablero[i][j] = true
                    end
                    
                end
        end

        @tablero = nuevoTablero
    end

  end
  
  # Creación de objetos de la clase Persona
  JuegoDeLaVida2 = JuegoDeLaVida.new()
  
  # Llamada a métodos de los objetos
 
   
  JuegoDeLaVida2.creacionTablero
  50.times do
    system('clear') || system('cls')
    JuegoDeLaVida2.siguienteGeneracion 
    JuegoDeLaVida2.mostrarTablero
    sleep(0.5)
  end
 

 

  
