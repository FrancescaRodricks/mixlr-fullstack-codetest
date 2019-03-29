class Mixlr::Fullstack::Stream
  attr_accessor :mean_volume, :max_volume, :name

  def initialize(name, mean_volume, max_volume)
    @name = name
    @mean_volume = mean_volume
    @max_volume = max_volume
  end

end