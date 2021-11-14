require 'rails_helper'

RSpec.describe Api::V1::ForecastFacade do
  describe 'class methods' do
    it '#forecast' do
      VCR.turn_off!
      VCR.eject_cassette
      # The stubs test the fact that the service calls are actually made. Webmock will throw an error if these are wrong.
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=38.892062&lon=-77.019912&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_washington_dc.json')))

      params = { location: 'Washington,DC' }
      result = Api::V1::ForecastFacade.forecast(params)

      expect(result).to be_a(Forecast)
      expect(result.current).to be_a(CurrentForecast)
      expect(result.daily.length).to eq(5)
      expect(result.daily.first).to be_a(DailyForecast)
      expect(result.hourly.length).to eq(8)
      expect(result.hourly.first).to be_a(HourlyForecast)
    end
  end
end
