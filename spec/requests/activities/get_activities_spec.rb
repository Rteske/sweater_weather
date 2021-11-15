require 'rails_helper'

RSpec.describe 'GET api/v1/activities' do
  describe 'return value' do
    it 'returns certain json format' do
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=38.892062&lon=-77.019912&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_washington_dc.json')))

      get "/api/v1/activities", params: { location: 'Washington,DC' }

    end
  end
end
