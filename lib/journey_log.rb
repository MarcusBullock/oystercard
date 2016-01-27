class JourneyLog

  attr_reader :journey_klass, :journey_log

  def initialize(journey_klass=Journey)
    @journey_log = []
    @journey_klass = journey_klass
  end

  def start_journey(entry_station)
    @journey = journey_klass.new
    @journey.start_journey(entry_station)
  end


  def current_journey
    @journey ||= journey_klass.new
  end

  def exit_journey(exit_station)
    @journey.end_journey(exit_station)
  end


end
