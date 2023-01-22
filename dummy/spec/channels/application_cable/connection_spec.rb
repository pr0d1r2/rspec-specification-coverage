# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'
require_relative '../../../app/channels/application_cable/connection'
require 'action_cable/connection'

::RSpec.describe(::ApplicationCable::Connection) do
  it { expect(described_class.ancestors).to(include(::ActionCable::Connection::Base)) }
end
