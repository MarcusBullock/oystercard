class Oystercard
  attr_reader :balance, :entry_station, :trip_history

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @max_balance = MAX_BALANCE
    @entry_station = nil
    @trip_history = []
  end

  def top_up amount
    fail "Max balance is £#{MAX_BALANCE}" if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in entry_station
    fail "Insufficient balance" if balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out exit_station
    deduct(MIN_FARE)
    add_to_history exit_station
    @entry_station = nil
  end


  def in_journey?
    !!@entry_station
  end

  private

  def deduct amount
    @balance -= amount
  end

  def add_to_history(exit_station)
    @trip_history  <<  {:entry_station => @entry_station, :exit_station => exit_station}
  end

end
