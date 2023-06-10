# frozen_string_literal: true

require 'minitest/autorun'

require_relative 'game_of_life_base'
require_relative 'game_of_life_custom'

class TestGameOfLife < Minitest::Test
  def setup
    @base = GameOfLife.new(5, 5, '_', 'A')
    @custom = GameOfLifeCustom.new(2, 4, '_', 'A')
  end

  def test_create_grid
    @base.create_grid
    assert_equal [
      [false, false, false, false, false],
      [false, true, false, false, false],
      [true, true, true, false, false],
      [false, true, false, false, false],
      [false, false, false, false, false]
    ], @base.grid
  end

  def test_create_grid_custom
    @custom.create_grid
    assert_equal [
      [false, false],
      [false, true],
      [true, true],
      [false, true]
    ], @custom.grid
  end

  def test_count_live_neighbours
    @base.create_grid
    assert_equal 1, @base.count_live_neighbours(0, 0)
    assert_equal 4, @base.count_live_neighbours(1, 2)
  end
end
