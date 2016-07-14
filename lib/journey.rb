class Journey
MIN_FARE = 1
PENALTY_FARE = 6

attr_reader :entry_station, :exit_station

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def in_progress?
    !!@entry_station
  end

  def fare
    !!@entry_station && !!@exit_station ? MIN_FARE : PENALTY_FARE
  end

end
