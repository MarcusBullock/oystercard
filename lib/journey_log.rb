class JourneyLog

  attr_reader :journey_log

  def initialize
    @journey_log = []
  end

  def start_journey(entry_station)
    journey_log << entry_station
    journey.start_journey
  end

  def current_journey
    journey_log
  end
end
