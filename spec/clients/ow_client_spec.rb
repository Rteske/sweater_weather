# require 'rails_helper'
#
# RSpec.describe OwClient do
#   describe 'class methods' do
#     it '#fetch(url, body)' do
#       stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['ow_api_key']}&exclude=minutely,alerts&lat=38.892062&lon=-77.019912&units=imperial").to_return(body: File.read(File.join('spec', 'fixtures', 'ow_washington_dc.json')))
#
#       results = OwClient.fetch('/data/2.5/onecall', { lat: 38.892062, lon: -77.019912, exclude: 'minutely,alerts', units: 'imperial' })
#       expect(results).to be_a(Hash)
#     end
#   end
# end
