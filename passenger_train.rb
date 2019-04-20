class PassengerTrain < Train
  @trains = {}

  def initialize(number)
    super(number)
    @type = :passenger
  end
end
