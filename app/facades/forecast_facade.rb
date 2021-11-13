class ForecastFacade
  class << self
    def forecast(params)
      coords = MqService.get_coords(params[:location])
      weather_data = OwService.get_forecast(coords)
      binding.pry
    end
  end
end
