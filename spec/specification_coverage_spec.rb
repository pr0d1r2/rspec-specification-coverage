# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

require_relative '../lib/rspec/specification_coverage/matchers/be_covered_with_specification'

::RSpec.describe('RSpec specification coverage') do
  loader_files = %w[lib/rspec-specification-coverage.rb lib/rspec/specification_coverage.rb]

  ::Dir['lib/**/*.rb'].reject { |a_file| loader_files.include?(a_file) }
                      .each do |a_file|
    describe a_file do
      subject(:file) { a_file.gsub(%r{^dummy/}, '') }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger) }
    end
  end
end
