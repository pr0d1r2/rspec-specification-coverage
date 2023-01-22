# frozen_string_literal: true

require 'rails_helper'
require 'rspec'
require_relative '../../app/controllers/application_controller'

::RSpec.describe(::ApplicationController) do
  describe 'routing' do
    it { expect(get: '/').to(route_to('dashboard#show')) }
  end
end
