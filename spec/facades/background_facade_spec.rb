require 'rails_helper'

RSpec.describe Api::V1::BackgroundFacade do
  describe 'class methods' do
    describe '#background(city)' do
      it 'will return a CityBackground object with attributes' do
        stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_api_key']}&page=1&per_page=1&query=Tampa%20Skyline").to_return(body: File.read(File.join('spec', 'fixtures', 'unsplash_tampa_skyline.json')))

        city = 'Tampa'
        results = Api::V1::BackgroundFacade.background(city)

        expect(results).to be_a(CityBackground)
        expect(results.image).to be_a(Image)
        expect(results.image.location).to be_a(String)
        expect(results.image.image_url).to be_a(String)
        expect(results.image.credit).to be_a(ImageCredit)
      end
    end
  end
end
