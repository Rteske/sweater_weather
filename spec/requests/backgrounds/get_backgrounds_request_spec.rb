require 'rails_helper'

RSpec.describe 'GET api/v1/backgrounds' do
  describe 'request return value' do
    it 'returns specific json format' do
      stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_api_key']}&page=1&per_page=1&query=Tampa%20Skyline").to_return(body: File.read(File.join('spec', 'fixtures', 'unsplash_tampa_skyline.json')))

      get '/api/v1/backgrounds', params: { location: 'Tampa,FL' }

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      background = response_body[:data]
      expect(background[:id]).to eq('null')
      expect(background[:type]).to eq('image')
      expect(background[:attributes]).to have_key(:image)
      expect(background[:attributes][:image]).to have_key(:location)
      expect(background[:attributes][:image][:location]).to be_a(String)
      expect(background[:attributes][:image]).to have_key(:image_url)
      expect(background[:attributes][:image][:image_url]).to be_a(String)
      expect(background[:attributes][:image]).to have_key(:credit)
      expect(background[:attributes][:image][:credit]).to have_key(:source)
      expect(background[:attributes][:image][:credit][:source]).to be_a(String)
      expect(background[:attributes][:image][:credit]).to have_key(:author)
      expect(background[:attributes][:image][:credit][:author]).to be_a(String)
      expect(background[:attributes][:image][:credit]).to have_key(:logo)
      expect(background[:attributes][:image][:credit][:logo]).to be_a(String)
    end
  end
end
