require 'rails_helper'

RSpec.describe Api::V1::ForecastFacade do
  describe 'class methods' do
    describe '#activities_by_location(destination)' do
      # The stubs test the fact that the service calls are actually made. Webmock will throw an error if these are wrong.

      describe 'objects returned' do
        it 'can return an ActivityForecast poro' do
          stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Tampa,FL").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_tampa_fl.json')))
          stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=27.947423&lon=-82.458776&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_tampa_fl.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=recreational").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_recreational.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=relaxation").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_relaxation.json')))

          destination = 'Tampa,FL'
          activities = Api::V1::ActivitiesFacade.activities_by_location(destination)

          expect(activities).to be_a(ActivityForecast)
          expect(activities.destination).to be_a(String)
          expect(activities.forecast).to be_a(ForecastShort)
          expect(activities.activities).to be_a(Array)
          expect(activities.activities.length).to eq(2)
          expect(activities.activities.first).to be_a(Activity)
        end
      end

      describe 'will return activity based on weather plus one relaxation activity' do
        it 'will return 1 recreational activity if the temp is >= 60' do
          stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Tampa,FL").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_tampa_fl.json')))
          stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=27.947423&lon=-82.458776&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_tampa_fl.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=recreational").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_recreational.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=relaxation").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_relaxation.json')))

          destination = 'Tampa,FL'
          activities = Api::V1::ActivitiesFacade.activities_by_location(destination)

          expect(activities.activities[1].type).to eq('relaxation')
          expect(activities.activities[0].type).to eq('recreational')
        end

        it 'will return 1 busy activity if the temp is >= 50 F and < 60 F' do
          stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Atlanta,GA").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_atlanta_ga.json')))
          stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=33.748547&lon=-84.391502&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_atlanta_ga.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=busywork").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_cooking.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=relaxation").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_relaxation.json')))

          destination = 'Atlanta,GA'
          activities = Api::V1::ActivitiesFacade.activities_by_location(destination)

          expect(activities.activities[1].type).to eq('relaxation')
          expect(activities.activities[0].type).to eq('cooking')
        end

        it 'will return 1 cooking activity if temp is < 50 F' do
          stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))
          stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=38.892062&lon=-77.019912&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_washington_dc.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=cooking").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_cooking.json')))
          stub_request(:get, "http://www.boredapi.com/api/activity?type=relaxation").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_relaxation.json')))

          destination = 'Washington,DC'
          activities = Api::V1::ActivitiesFacade.activities_by_location(destination)

          expect(activities.activities[1].type).to eq('relaxation')
          expect(activities.activities[0].type).to eq('cooking')
        end
      end
    end
  end
end
