require 'rails_helper'

RSpec.describe 'Get Forecast', type: :request do
  describe "get 'api/v1/forecast?location=string'" do
    it 'returns a current weather forecast' do
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=38.892062&lon=-77.019912&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_washington_dc.json')))

      get "/api/v1/forecast", params: { location: 'Washington,DC' }

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      forecast = response_body[:data]
      expect(forecast[:id]).to eq('null')
      expect(forecast[:type]).to eq('forecast')
      expect(forecast[:attributes]).to have_key(:current_weather)
      expect(forecast[:attributes][:current_weather]).to have_key(:datetime)
      expect(forecast[:attributes][:current_weather]).to have_key(:sunrise)
      expect(forecast[:attributes][:current_weather]).to have_key(:sunset)
      expect(forecast[:attributes][:current_weather]).to have_key(:tempature)
      expect(forecast[:attributes][:current_weather]).to have_key(:feels_like)
      expect(forecast[:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast[:attributes][:current_weather]).to have_key(:uvi)
      expect(forecast[:attributes][:current_weather]).to have_key(:visibility)
      expect(forecast[:attributes][:current_weather]).to have_key(:conditions)
      expect(forecast[:attributes][:current_weather]).to have_key(:icon)
    end

    it 'returns 5 daily weather forecasts' do
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=38.892062&lon=-77.019912&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_washington_dc.json')))

      get "/api/v1/forecast", params: { location: 'Washington,DC' }

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      forecast = response_body[:data]

      expect(forecast[:attributes]).to have_key(:daily_weather)
      expect(forecast[:attributes][:daily_weather].length).to eq(5)

      daily_weather_forecast = forecast[:attributes][:daily_weather].first

      expect(daily_weather_forecast).to have_key(:date)
      expect(daily_weather_forecast).to have_key(:sunrise)
      expect(daily_weather_forecast).to have_key(:sunset)
      expect(daily_weather_forecast).to have_key(:max_temp)
      expect(daily_weather_forecast).to have_key(:min_temp)
      expect(daily_weather_forecast).to have_key(:conditions)
      expect(daily_weather_forecast).to have_key(:icon)
    end

    it 'returns 8 hourly weather forecasts' do
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=38.892062&lon=-77.019912&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_washington_dc.json')))

      get "/api/v1/forecast", params: { location: 'Washington,DC' }

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      forecast = response_body[:data]

      expect(forecast[:attributes]).to have_key(:hourly_weather)
      expect(forecast[:attributes][:hourly_weather].length).to eq(8)

      hourly_weather_forecast = forecast[:attributes][:hourly_weather].first

      expect(hourly_weather_forecast).to have_key(:time)
      expect(hourly_weather_forecast).to have_key(:tempature)
      expect(hourly_weather_forecast).to have_key(:conditions)
      expect(hourly_weather_forecast).to have_key(:icon)
    end
  end
end
