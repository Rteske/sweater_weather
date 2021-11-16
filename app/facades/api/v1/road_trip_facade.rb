class Api::V1::RoadTripFacade
  class << self
    def route_forecast(from, to)
      route_data = MqService.get_route(from, to)

      travel_time = route_data[:route][:formattedTime]
      travel_hours = travel_time.split(':')
      travel_hours = travel_hours.first.to_i

      departure_forecast_data = OwService.get_current_and_hourly_forecast(route_data[:route][:locations].first[:latLng])
      destination_forecast_data = OwService.get_current_and_hourly_forecast(route_data[:route][:locations].last[:latLng])

      departure_time = unix_to_datetime(departure_forecast_data[:current][:dt])
      arrival_time = add_hours_to_datetime(departure_time, travel_hours)

      hourly_arr = destination_forecast_data[:hourly]
      destination_forecast = hourly_forecast_picker(hourly_arr, arrival_time)

      tempature = destination_forecast[:temp]
      summary = destination_forecast[:weather].first[:description]

      forecast = ForecastShort.new(summary, tempature)
      RoadTrip.new(from, to, travel_time, forecast)
    end

    private

    def unix_to_datetime(dt)
      Time.at(dt).to_datetime
    end

    def add_hours_to_datetime(dt, hrs)
      (Time.at(dt) + hrs.hours).to_datetime
    end

    def hourly_forecast_picker(hourly_arr, arrival_time)
      hourly_arr.min do |forecast|
        unix_to_datetime(forecast[:dt]) - arrival_time
      end
    end
  end
end
