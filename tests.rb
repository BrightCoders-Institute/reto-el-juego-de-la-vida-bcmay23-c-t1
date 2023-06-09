require 'minitest/autorun'

require_relative 'game_of_life_base'
require_relative 'game_of_life_custom'

class TestGameOfLife < Minitest::Test
  def setup
    @base = GameOfLife.new(5, 5, '_', 'A')
    # @custom = GameOfLifeCustom.new('_', 'A')
  end

  def test_create_grid
    @base.create_grid
    assert_equal 1, @base.matrix#[
      # ".....",
      # ".*...",
      # ".....",
      # ".....",
      # ".....",
    # ],
    # ,  @base.width.class
  end
end