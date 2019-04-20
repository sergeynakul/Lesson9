class Train
  include Produser
  include InstanceCounter
  include Validation
  attr_accessor :speed
  attr_reader :carriages, :type, :number
  @trains = {}

  NUMBER_FORMAT = /[a-zа-я0-9]{3}\-?[a-zа-я0-9]{2}/i.freeze

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @carriages = []
    self.class.trains[self.number] = self
    register_instance
  end

  def stop
    @speed = 0
  end

  def take_route(route)
    @route = route
    @route.stations.first.take_train(self)
    @station_index = 0
  end

  def go_forward
    return unless next_station

    current_station.send_train(self)
    next_station.take_train(self)
    @station_index += 1
  end

  def go_back
    return unless previous_station

    current_station.send_train(self)
    previous_station.take_train(self)
    @station_index -= 1
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1] if @route.stations.length > @station_index + 1
  end

  def previous_station
    @route.stations[@station_index - 1] if @station_index > 0
  end

  def self.find(number)
    self.class.trains[number]
  end

  def each_carriage
    @carriages.each { |carriage| yield carriage }
  end

  private

  def validate!
    raise ArgumentError, 'Поезд не может быть без номера' if number == ''
    raise ArgumentError, 'Не верный формат номера поезда' if number !~ NUMBER_FORMAT
  end
end
