require 'rails_helper'

RSpec.describe BoredService do
  describe 'class methods' do
    it '#get_coords' do
      stub_request(:get, "http://www.boredapi.com/api/activity?type=recreational").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_recreational.json')))

      type = 'recreational'
      results = BoredService.get_type_activity(type)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:activity)
      expect(results).to have_key(:type)
      expect(results).to have_key(:participants)
      expect(results).to have_key(:price)
      expect(results).to have_key(:link)
      expect(results).to have_key(:key)
      expect(results).to have_key(:accessibility)
    end
  end
end
