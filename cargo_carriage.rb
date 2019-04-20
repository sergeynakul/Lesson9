class CargoCarriage
  include Produser
  attr_reader :type, :current_fill_volume
  def initialize(volume)
    @volume = volume
    @type = :cargo
    @current_fill_volume = 0
  end

  def fill_volume(volume)
    if (@current_fill_volume + volume) > @volume
      @current_fill_volume = @volume
    else
      @current_fill_volume += volume
    end
  end

  def current_free_volume
    @volume - @current_fill_volume
  end
end
