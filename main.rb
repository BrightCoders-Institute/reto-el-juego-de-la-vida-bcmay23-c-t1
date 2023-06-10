# frozen_string_literal: true

require_relative 'game_of_life_base'
require_relative 'game_of_life_custom'

# game = GameOfLife.new(5, 5, '_', 'A')
# game.create_grid
# game.show_grid
# puts game.count_live_neighbours(0, 0)
# game.loop(5)

custom = GameOfLifeCustom.new(5, 5, '_', '@')
# custom.create_grid
# custom.show_grid
# custom.next_generation
custom.loop(5)
