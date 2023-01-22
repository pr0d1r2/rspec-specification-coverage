# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'active_support/core_ext/module'
require 'rspec'
require 'singleton'

# We store it within rspec as it relies on it.
module RSpec
  # "RSpec specification coverage" is a term we use to go beyond testing.
  module SpecificationCoverage
    # Stores instance of currently changed git files.
    class GitFilesChanged
      include ::Singleton

      delegate :include?, to: :ALL

      # All git files changed.
      ALL = `git status --porcelain | grep -v "^D" | cut -b4-`.split("\n").reject(&:empty?).freeze

      private_constant :ALL
    end
  end
end
