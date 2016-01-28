require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_list, :entry_station, :journey_class, :current_journey
  
  BALANCE_MAX = 90

  def initialize(journey_class = Journey)
    @balance = 0
    @journey_list = []
    @journey_class = journey_class
  end

  def top_up(value)
    raise 'Top-up exceeds maximum limit of #{BALANCE_MAX}' if @balance + value > BALANCE_MAX
    @balance += value
  end

  def touch_in(station)
    if @current_journey != nil
    end_journey(nil)
    end
    raise 'Please top up your card.' if @balance < Journey::FARE_MIN
    @current_journey = @journey_class.new(station)
  end

  def touch_out(station)
    if @current_journey == nil
      @current_journey = @journey_class.new(nil)
    end
    end_journey(station)
  end
  

  private

  def deduct(value)
    @balance -= value
  end

  def journey_capture
     @journey_list << @current_journey
     @current_journey = nil 
  end
  
  def end_journey(station)
    @current_journey.exit(station)
    deduct(@current_journey.fare)
    journey_capture
    
  end
end 
