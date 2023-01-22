# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

require_relative '../../app/models/application_record'

::RSpec.describe(::ApplicationRecord) do
  it { expect(described_class).to(be_abstract_class) }
end
