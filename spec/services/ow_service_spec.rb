require 'rails_helper'

RSpec.describe OwService do
  describe 'class methods' do
    describe '#get_forecast' do
      it 'Happy Path' do
        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=67118518bc82473a9afee56f4dd5b48e&exclude=minutely,alerts&lat=39.526903&lon=-119.813283&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_reno_get_forecast.json')))

        coords = { lat: 39.526903, lng: -119.813283 }
        results = OwService.get_forecast(coords)
        expect(results).to be_a(Hash)
        expect(results).to have_key(:current)
        expect(results).to have_key(:daily)
        expect(results).to have_key(:hourly)
        expect(results).to_not have_key(:minutely)
        expect(results).to_not have_key(:alerts)
      end
    end

    describe '#get_current_and_daily_forecast' do
      it 'Happy Path' do
        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=67118518bc82473a9afee56f4dd5b48e&exclude=hourly,minutely,alerts&lat=39.526903&lon=-119.813283&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_reno_get_current_and_daily.json')))

        coords = { lat: 39.526903, lng: -119.813283 }
        results = OwService.get_current_and_daily_forecast(coords)
        expect(results).to be_a(Hash)
        expect(results).to have_key(:current)
        expect(results).to have_key(:daily)
        expect(results).to_not have_key(:hourly)
        expect(results).to_not have_key(:minutely)
        expect(results).to_not have_key(:alerts)
      end
    end

    describe '#get_current_and_hourly_forecast' do
        it 'Happy Path' do
          stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=67118518bc82473a9afee56f4dd5b48e&exclude=daily,minutely,alerts&lat=39.526903&lon=-119.813283&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_reno_get_current_and_hourly.json')))

          coords = { lat: 39.526903, lng: -119.813283 }
          results = OwService.get_current_and_hourly_forecast(coords)
          expect(results).to be_a(Hash)
          expect(results).to have_key(:current)
          expect(results).to have_key(:hourly)
          expect(results).to_not have_key(:daily)
          expect(results).to_not have_key(:minutely)
          expect(results).to_not have_key(:alerts)
        end
    end
  end
end
