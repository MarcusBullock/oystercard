require_relative 'journey'


class Oystercard

  attr_reader :balance, :journey

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @hist = []
  end

  def topup(value)
    fail "Exceeded max limit: #{MAX_LIMIT}" if balance + value > MAX_LIMIT
    @balance += value
  end

  def in_journey?
    !!@journey_new
  end

  def touch_in(station,journey_klass=Journey)
    fail 'low balance' if balance < MIN_FARE
    deduct(@journey_new.calculate_fare) if in_journey?
    @journey_new = journey_klass.new
    @journey_new.start_journey(station)
  end

  def touch_out(station,journey_klass=Journey)
    @journey_new ||= journey_klass.new
    @journey_new.end_journey(station)
    deduct(@journey_new.calculate_fare)
    @hist << @journey_new
    @journey_new = nil
  end

  def hist
    @hist.clone
  end

  private

  def deduct(value)
    @balance -= value
  end

end
