class CargoTrain < Train
  @trains = {}

  def initialize(number)
    super(number)
    @type = :cargo
  end
end
