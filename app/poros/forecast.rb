class Forecast
  attr_accessor :id, :current_weather, :daily_weather, :hourly_weather
  def initialize(current_forecast, daily_forecast, hourly_forecast)
    @current_weather = current_forecast
    @daily_weather = daily_forecast
    @hourly_weather = hourly_forecast
  end
end
