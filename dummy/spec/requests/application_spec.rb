# frozen_string_literal: true

require 'rails_helper'
require 'rspec'

::RSpec.describe('main application request') do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to(have_http_status(:success))
    end
  end
end
