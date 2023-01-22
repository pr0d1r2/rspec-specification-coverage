# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'
require_relative '../../../app/channels/application_cable/channel'
require 'action_cable/channel'

::RSpec.describe(::ApplicationCable::Channel) do
  it { expect(described_class.ancestors).to(include(::ActionCable::Channel::Base)) }
end
