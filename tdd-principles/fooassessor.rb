class FooAssessor
  def initialize(bike_gears)
    @gears = bike_gears
  end

  def has_fixie?
    @gears == 1
  end
end
