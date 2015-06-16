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

  def landing plane # try to refactor this as we did above
    if @planes.count >= DEFAULT_CAPACITY
      fail 'The airport is full!'
    elsif plane.landed? == true
      fail 'That plane has already landed!'
    elsif stormy?
      fail 'It\'s too stormy to land!'
    else
      plane.land
      @planes << plane
    end
  end

  def check_conditions
    fail 'No planes to take off!'   if empty?
    fail 'It\'s too stormy to fly!' if stormy?
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

end
