require "test/unit"
require './fooassessor'

class FooTest < Test::Unit::TestCase

  def setup
    @developer = FooAssessor.new(gears_on_bike=1)
  end

  def test_has_fixie?
    assert_equal true, @developer.has_fixie?
  end

end
