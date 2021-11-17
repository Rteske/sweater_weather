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

      if destination_forecast_data[:timezone] == departure_forecast_data[:timezone]
        arrival_time = add_hours_to_datetime(departure_time, travel_hours)
        destination_forecast = hourly_picker(destination_forecast_data[:hourly], arrival_time)
        tempature = destination_forecast[:temp]
      else
        destination_forecast_data = OwService.get_current_and_daily_forecast(route_data[:route][:locations].last[:latLng])
        departure_time = set_timezone(departure_time, destination_forecast_data[:timezone])
        arrival_time = add_hours_to_datetime(departure_time, travel_hours)
        destination_forecast = daily_picker(destination_forecast_data[:daily], arrival_time)
        tempature = destination_forecast[:temp][:day]
      end

      forecast = ForecastShort.new(destination_forecast[:weather].first[:description], tempature)
      RoadTrip.new(from, to, travel_time, forecast)
    end

    private

    def unix_to_datetime(dt)
      Time.at(dt).to_datetime
    end

    def set_timezone(dt, timezone)
      Time.at(dt).in_time_zone(timezone)
    end

    def add_hours_to_datetime(dt, hrs)
      (Time.at(dt) + hrs.hours).to_datetime
    end

    def hourly_picker(forecast_arr, arrival_time)
      forecast_arr.min do |forecast|
        unix_to_datetime(forecast[:dt]) - arrival_time
      end
    end

    def daily_picker(forecast_arr, arrival_time)
      forecast_arr.find do |forecast|
        unix_to_datetime(forecast[:dt]).strftime('%F') == arrival_time.strftime('%F')
      end
    end
  end
end
