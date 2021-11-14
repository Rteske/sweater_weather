class Api::V1::ForecastFacade
  class << self
    def forecast(params)
      coords = MqService.get_coords(params[:location])
      weather_data = OwService.get_forecast(coords)
      daily = five_day(weather_data[:daily])
      hourly = eight_hours(weather_data[:hourly])
      current = CurrentForecast.new(weather_data[:current])
      Forecast.new(current, daily, hourly)
    end

    private

    def five_day(daily_data)
      daily = []
      n = 0
      until n == 5
        daily << DailyForecast.new(daily_data[n])
        n += 1
      end
      daily
    end

    def eight_hours(hourly_data)
      hourly = []
      n = 0
      until n == 8
        hourly << HourlyForecast.new(hourly_data[n])
        n += 1
      end
      hourly
    end
  end
end
