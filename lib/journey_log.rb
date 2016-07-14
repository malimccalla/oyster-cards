require_relative 'journey'

class JourneyLog

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @log = []
    @current_journey = @journey_class.new
  end

  def start(entry_station)
    @current_journey.start(entry_station)
  end

  def finish(exit_station)
    @current_journey.finish(exit_station)
  end

  def log_journey
    @log << @current_journey
    @current_journey = @journey_class.new
  end

  def journeys
    @journeys.dup
  end

  def charge
    fare
  end

  def touch_in_charge
    if @current_journey.in_progress?
      log_journey
      charge
    end
  end

end
