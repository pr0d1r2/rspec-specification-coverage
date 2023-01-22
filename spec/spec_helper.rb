# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

::RSpec.configure do |config|
  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  parallel_run = ::ENV.fetch('TEST_ENV_NUMBER', false)

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching(:focus) unless parallel_run
  config.example_status_persistence_file_path = 'tmp/spec_examples.txt'
  config.disable_monkey_patching!
  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one? || parallel_run

  config.profile_examples = 1 unless parallel_run
  config.order = :random
  ::Kernel.srand(config.seed)
end

require 'simplecov'
::SimpleCov.start do
  enable_coverage :branch
  add_filter 'spec'
end
::SimpleCov.minimum_coverage(100)
