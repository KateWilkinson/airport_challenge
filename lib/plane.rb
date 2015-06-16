class Plane
  attr_accessor :landed

  def initialize
    self.landed = false
  end

  def flying?
    !landed
  end

  def landed?
    landed
  end

  def land
    self.landed = true
  end

  def take_off
    self.landed = false
    self
  end

end
