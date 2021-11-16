require 'rails_helper'

RSpec.describe UnsplashService do
  describe 'class methods' do
    it '#get_background_pic(city)' do
      stub_request(:get, "https://api.unsplash.com/search/photos?api_key=#{ENV['unsplash_api_key']}&page=1&per_page=1&query=Tampa%20Skyline").to_return(body: File.read(File.join('spec', 'fixtures', 'unsplash_tampa_skyline.json')))

      city = 'Tampa'
      results = UnsplashService.get_background_pic(city)

      expect(results).to be_a(Hash)
    end
  end
end
