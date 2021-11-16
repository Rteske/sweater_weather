require 'rails_helper'

RSpec.describe 'POST api/v1/users' do
  describe 'new user request' do
    it 'if credentials are good will create user and return json' do
      post '/api/v1/users', params: { email: 'ryanteske@outlook.com', password: 'doggy', password_confirmation: 'doggy'}

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      response = response_body[:data]
      expect(response).to have_key(:id)
      expect(response).to have_key(:type)
      expect(response[:type]).to eq('users')
      expect(response).to have_key(:attributes)
      expect(response[:attributes]).to have_key(:email)
      expect(response[:attributes]).to have_key(:api_key)
    end
  end
end
