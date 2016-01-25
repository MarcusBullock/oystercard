class Oystercard

  attr_reader :balance, :entry_station, :exit_station

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @hist = []
  end

  def topup(value)
    fail "Exceeded max limit: #{MAX_LIMIT}" if @balance + value >= MAX_LIMIT
    @balance += value
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in station
    fail 'low balance' if balance < MIN_FARE
    @entry_station = station
    @exit_station = nil
  end

  def touch_out station
    deduct(MIN_FARE)
    @exit_station = station
    @hist << {entry_station => exit_station}
    @entry_station = nil
  end

  def hist
    @hist.clone
  end

  private

  def deduct(value)
    @balance -= value
  end

end
