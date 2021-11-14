require 'rails_helper'

RSpec.describe MqService do
  describe 'class methods' do
    it '#get_coords' do
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mq_api_key']}&location=Washington,DC").to_return(body: File.read(File.join('spec', 'fixtures', 'mq_washington_dc.json')))

      state = 'Washington,DC'
      results = MqService.get_coords(state)
      
      expect(results).to be_a(Hash)
      expect(results).to have_key(:lat)
      expect(results).to have_key(:lng)
    end
  end
end
