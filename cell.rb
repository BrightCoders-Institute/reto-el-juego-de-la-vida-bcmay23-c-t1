class Cell
  attr_accessor :neighbors, :positionX, :positionY
  def initialize(positionX, positionY)
    @neighbors = 0
    @positionX = positionX
    @positionY = positionY
  end
end