require 'rails_helper'

RSpec.describe UnsplashClient do
  describe 'class methods' do
    it '#fetch(url, body)' do
      stub_request(:get, "https://api.unsplash.com/search/photos?api_key=#{ENV['unsplash_api_key']}&page=1&per_page=1&query=Tampa%20Skyline").to_return(body: File.read(File.join('spec', 'fixtures', 'unsplash_tampa_skyline.json')))

      results = UnsplashClient.fetch('/search/photos', { query: 'Tampa Skyline', page: 1, per_page: 1 })
      expect(results).to be_a(Hash)
    end
  end
end
