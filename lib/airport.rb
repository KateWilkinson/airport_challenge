require_relative 'plane'

class Airport

  DEFAULT_CAPACITY = 15

  def initialize
    @planes = []
  end

  def capacity
    @capacity = DEFAULT_CAPACITY
  end

  def requesting_take_off
    check_conditions
    plane = @planes.pop
    plane.take_off
  end

  def empty?
    @planes.empty?
  end

  def landing plane
    check_landing_conditions plane
    plane.land
    @planes << plane
  end

  def check_conditions
    fail 'No planes to take off!'   if empty?
    fail 'It\'s too stormy to fly!' if stormy?
  end

  def check_landing_conditions plane
    fail 'The airport is full!' if full?
    fail 'That plane has already landed!' if plane.landed?
    fail 'It\'s too stormy to land!' if stormy?
  end

  def weather
    rand(11)
  end

  def forecast
    if weather == 10
      'stormy'
    else
      'sunny'
    end
  end

  def stormy?
    forecast == 'stormy'
  end

  def full?
    @planes.count >= DEFAULT_CAPACITY
  end

end
