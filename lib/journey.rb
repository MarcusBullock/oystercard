class Journey

  attr_reader :entry_station
  PENALTY_FARE = 6

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def calculate_fare
    @entry_station && @exit_station ? Oystercard::MIN_FARE : PENALTY_FARE
  end

end
