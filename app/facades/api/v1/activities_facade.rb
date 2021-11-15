class Api::V1::ActivitiesFacade
  class << self
    def activities_by_location(destination)
      coords = MqService.get_coords(destination)
      weather_data = OwService.get_forecast(coords)
      current = CurrentForecast.new(weather_data[:current])

      if current.tempature >= 60
        activity_data = BoredService.get_type_activity('recreational')
        activity1 = Activity.new(activity_data[:activity], activity_data[:type], activity_data[:participants], activity_data[:price])
      elsif current.tempature >= 50 && current.tempature < 60
        activity_data = BoredService.get_type_activity('busywork')
        activity1 = Activity.new(activity_data[:activity], activity_data[:type], activity_data[:participants], activity_data[:price])
      elsif current.tempature < 50
        activity_data = BoredService.get_type_activity('cooking')
        activity1 = Activity.new(activity_data[:activity], activity_data[:type], activity_data[:participants], activity_data[:price])
      end
      activity_data = BoredService.get_type_activity('relaxation')
      activity2 = Activity.new(activity_data[:activity], activity_data[:type], activity_data[:participants], activity_data[:price])

      forecast = ForecastShort.new(current.conditions, current.tempature)
      activities = [activity1, activity2]
      ActivityForecast.new(destination, forecast, activities)
    end
  end
end
