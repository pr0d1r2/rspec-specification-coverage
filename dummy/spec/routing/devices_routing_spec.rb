# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require_relative '../../app/controllers/devices_controller'

require 'rails_helper'
require 'rspec'

::RSpec.describe(::DevicesController) do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/devices').to(route_to('devices#index'))
    end

    it 'routes to #new' do
      expect(get: '/devices/new').to(route_to('devices#new'))
    end

    it 'routes to #show' do
      expect(get: '/devices/1').to(route_to('devices#show', id: '1'))
    end

    it 'routes to #edit' do
      expect(get: '/devices/1/edit').to(route_to('devices#edit', id: '1'))
    end

    it 'routes to #create' do
      expect(post: '/devices').to(route_to('devices#create'))
    end

    it 'routes to #update via PUT' do
      expect(put: '/devices/1').to(route_to('devices#update', id: '1'))
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/devices/1').to(route_to('devices#update', id: '1'))
    end

    it 'routes to #destroy' do
      expect(delete: '/devices/1').to(route_to('devices#destroy', id: '1'))
    end

    # controller uses set_device and device_params methods internally.
  end
end
