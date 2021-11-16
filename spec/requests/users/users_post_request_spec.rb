require 'rails_helper'

RSpec.describe 'POST api/v1/users' do
  describe 'valid new user request' do
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
      expect(response[:attributes][:email]).to eq('ryanteske@outlook.com')
      expect(response[:attributes]).to have_key(:api_key)
    end
  end

  describe 'invalid new user request' do
    it 'if passwords do not match returns a response corresponding' do
      post '/api/v1/users', params: { email: 'ryanteske@outlook.com', password: 'gy', password_confirmation: 'doggy'}

      expect(response).to_not be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body).to have_key(:password_confirmation)
      expect(response_body[:password_confirmation].first).to eq("doesn't match Password")
    end

    it 'if email is inncorrect format' do
      post '/api/v1/users', params: { email: 'ryanlookcom', password: 'doggy', password_confirmation: 'doggy'}

      expect(response).to_not be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body).to have_key(:email)
      expect(response_body[:email].first).to eq("is invalid")
    end

    it 'if email is already in database' do
      user1 = User.create!({ email: 'ryanteske@outlook.com', password: 'doggy', password_confirmation: 'doggy'})
      post '/api/v1/users', params: { email: 'ryanteske@outlook.com', password: 'doggy', password_confirmation: 'doggy'}

      expect(response).to_not be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body).to have_key(:email)
      expect(response_body[:email].first).to eq("has already been taken")
    end
  end
end
