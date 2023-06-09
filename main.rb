# frozen_string_literal: true

require_relative 'game_of_life_base'
require_relative 'game_of_life_custom'

game = GameOfLife.new(5, 5, '_', 'A')
game.create_grid
# game.loop
# custom = GameOfLifeCustom.new(20, 20, '_', '@') 
# custom.loop
