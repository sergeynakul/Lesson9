class PassengerCarriage
  include Produser
  attr_reader :type, :taken_places
  def initialize(quantity)
    @quantity = quantity
    @type = :passenger
    @taken_places = 0
  end

  def take_place
    @taken_places += 1 if @taken_places < @quantity
  end

  def free_places
    @quantity - @taken_places
  end
end
