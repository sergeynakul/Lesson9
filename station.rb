class Station
  include InstanceCounter
  include Validation
  include Acсessors

  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :type, String

  @stations = []

  class << self
    attr_reader :stations

    def all
      @stations
    end
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.stations << self
    register_instance
  end

  def list(type)
    @trains.select { |train| train.type == type }
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield train }
  end
end
