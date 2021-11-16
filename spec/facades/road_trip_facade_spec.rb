require 'rails_helper'

RSpec.describe Api::V1::RoadTripFacade do
  describe 'class methods' do
    it '#route_forecast(from, to)' do
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Reno,NV&key=#{ENV['mq_api_key']}&to=Sacremento,CA").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_reno_to_sacremento.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=daily,minutely,alerts&lat=39.526903&lon=-119.813283&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_reno_nv.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=daily,minutely,alerts&lat=38.582087&lon=-121.50012&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_sacremento_ca.json')))

      from = 'Reno,NV'
      to = 'Sacremento,CA'
      results = Api::V1::RoadTripFacade.route_forecast(from, to)

      expect(results).to be_a(RoadTrip)
      expect(results.start_city).to eq('Reno,NV')
      expect(results.end_city).to eq('Sacremento,CA')
      expect(results.travel_time).to eq('02:08:47')
      expect(results.weather_at_eta).to be_a(ForecastShort)
      expect(results.weather_at_eta.summary).to eq('broken clouds')
      expect(results.weather_at_eta.tempature).to eq(63.3)
    end
  end
end
