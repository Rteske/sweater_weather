require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    # it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should allow_value('ryan@gmail.com').for(:email) }
    it { should_not allow_value('fuasd^6').for(:email) }
  end

  describe 'realationships' do
    it { should have_many(:api_keys) }
  end
end
