require 'rails_helper'

RSpec.describe MqClient do
  describe 'class methods' do
    it '#fetch(url, body)' do
      stub_request(:get, "http://www.boredapi.com/api/activity?type=recreational").to_return(body: File.read(File.join('spec', 'fixtures', 'bored_recreational.json')))

      results = BoredClient.fetch('/api/activity', { type: 'recreational' })
      expect(results).to be_a(Hash)
    end
  end
end
