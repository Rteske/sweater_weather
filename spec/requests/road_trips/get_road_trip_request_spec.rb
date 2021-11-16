require 'rails_helper'

RSpec.describe 'GET api/v1/road_trip' do
  describe 'HAPPY PATH RETURN VALUES' do
    it 'returns a json formmatted string' do
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Reno,NV&key=#{ENV['mq_api_key']}&to=Sacremento,CA").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_reno_to_sacremento.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=daily,minutely,alerts&lat=39.526903&lon=-119.813283&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_reno_nv.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=daily,minutely,alerts&lat=38.582087&lon=-121.50012&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_sacremento_ca.json')))

      user1 = User.create!(email: 'ryan@gamil.com', password: 'cool', password_confirmation: 'cool')
      user1_api_key = user1.api_keys.create!(token: SecureRandom.hex)
      get '/api/v1/road_trip', params: { origin: 'Reno,NV', destination: 'Sacremento,CA', api_key: user1_api_key.token }

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      response = response_body[:data]

      expect(response[:id]).to eq('null')
      expect(response[:type]).to eq('road trip')
      expect(response[:attributes]).to have_key(:start_city)
      expect(response[:attributes]).to have_key(:end_city)
      expect(response[:attributes]).to have_key(:travel_time)
      expect(response[:attributes]).to have_key(:weather_at_eta)
      expect(response[:attributes][:weather_at_eta]).to have_key(:summary)
      expect(response[:attributes][:weather_at_eta]).to have_key(:tempature)
    end
  end
end
