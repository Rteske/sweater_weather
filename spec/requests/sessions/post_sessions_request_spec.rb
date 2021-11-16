require 'rails_helper'

RSpec.describe 'POST api/v1/sessions' do
  describe 'valid user sign in' do
    it 'will return a JSON string' do
      user1 = User.create!({ email: 'ryan@gmail.com', password: 'doggy', password_confirmation: 'doggy'})
      user1_api_key = user1.api_keys.create!({ token: SecureRandom.hex })
      post '/api/v1/sessions', params: { email: 'ryan@gmail.com', password: 'doggy' }

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      response = response_body[:data]
      expect(response).to have_key(:id)
      expect(response[:id]).to eq(user1.id.to_s)
      expect(response).to have_key(:type)
      expect(response[:type]).to eq('users')
      expect(response).to have_key(:attributes)
      expect(response[:attributes]).to have_key(:email)
      expect(response[:attributes][:email]).to eq(user1.email)
      expect(response[:attributes]).to have_key(:api_key)
    end
  end

  describe 'invailid user sign in' do
    it 'will return an invalid credentials 401 for wrong password' do
      user1 = User.create!({ email: 'ryan@gmail.com', password: 'doggy', password_confirmation: 'doggy'})
      user1_api_key = user1.api_keys.create!({ token: SecureRandom.hex })
      post '/api/v1/sessions', params: { email: 'ryan@gmail.com', password: 'dgy' }

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response.body).to eq('bad credentials')
    end
  end
end
