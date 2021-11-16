require 'rails_helper'

RSpec.describe ApiKey do
  describe 'realationships' do
    it { should belong_to(:bearer) }
  end
end
