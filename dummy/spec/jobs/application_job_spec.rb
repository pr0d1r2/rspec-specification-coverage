# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'
require_relative '../../app/jobs/application_job'

::RSpec.describe(::ApplicationJob) do
  it { expect(described_class.ancestors).to(include(::ActiveJob::Base)) }
end
