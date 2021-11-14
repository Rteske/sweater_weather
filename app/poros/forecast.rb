class Forecast
  attr_accessor :id, :current, :daily, :hourly
  def initialize(current_forecast, daily_forecast, hourly_forecast)
    @current = current_forecast
    @daily = daily_forecast
    @hourly = hourly_forecast
    @id = 1
  end
end
