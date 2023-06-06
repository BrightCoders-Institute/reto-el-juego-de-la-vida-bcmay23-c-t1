class Celula
  attr_accessor :vecinos, :posicionX, :posicionY
  def initialize(posicionX, posicionY)
    @vecinos = 0
    @posicionX = posicionX
    @posicionY = posicionY
  end
end