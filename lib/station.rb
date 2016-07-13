class Station

  attr_reader :info

  def initialize(name,zone)
    @info = {name: name, zone: zone}
  end

  def zone
    @info[:zone]
  end

  def name
    @info[:name]
  end
end
