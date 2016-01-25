class Oystercard

  attr_reader :balance, :entry_station, :exit_station

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @journeys = []
  end

  def topup(value)
    fail "Exceeded max limit: #{MAX_LIMIT}" if balance + value > MAX_LIMIT
    @balance += value
  end

  def in_journey?
    true if @entry_station
  end

  def touch_in station
    fail 'low balance' if balance < MIN_FARE
    @entry_station = station
    @exit_station = nil
  end

  def touch_out station
    deduct(MIN_FARE)
    @exit_station = station
    @journeys << {entry_station: entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  def journeys
    @journeys.clone
  end

  private

  def deduct(value)
    @balance -= value
  end

end
