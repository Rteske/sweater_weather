# require 'rails_helper'
#
# RSpec.describe MqClient do
#   describe 'class methods' do
#     it '#fetch(url, body)' do
#       stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))
#
#       results = MqClient.fetch('/geocoding/v1/address', { location: 'Washington,DC' })
#       expect(results).to be_a(Hash)
#     end
#   end
# end
