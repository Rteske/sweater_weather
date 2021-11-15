require 'rails_helper'

RSpec.describe 'GET api/v1/activities' do
  describe 'return value' do
    it 'returns certain json format' do
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Atlanta,GA").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_atlanta_ga.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=33.748547&lon=-84.391502&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_atlanta_ga.json')))
      stub_request(:get, "http://www.boredapi.com/api/activity?type=busywork").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_cooking.json')))
      stub_request(:get, "http://www.boredapi.com/api/activity?type=relaxation").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_relaxation.json')))

      get "/api/v1/activities", params: { destination: 'Atlanta,GA' }

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      activity_forecast = response_body[:data]

      expect(activity_forecast[:id]).to eq('null')
      expect(activity_forecast[:type]).to eq('activities')
      expect(activity_forecast[:attributes]).to have_key(:destination)
      expect(activity_forecast[:attributes][:destination]).to be_a(String)

      expect(activity_forecast[:attributes]).to have_key(:forecast)
      expect(activity_forecast[:attributes][:forecast]).to have_key(:summary)
      expect(activity_forecast[:attributes][:forecast]).to have_key(:tempature)

      expect(activity_forecast[:attributes]).to have_key(:activities)
      expect(activity_forecast[:attributes][:activities]).to be_a(Array)
      expect(activity_forecast[:attributes][:activities].length).to eq(2)

      activity1 = activity_forecast[:attributes][:activities].first

      expect(activity1).to have_key(:title)
      expect(activity1).to have_key(:type)
      expect(activity1).to have_key(:participants)
      expect(activity1).to have_key(:price)
    end
  end
end
