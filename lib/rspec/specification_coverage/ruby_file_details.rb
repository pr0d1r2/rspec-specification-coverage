# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

# We store it within rspec as it relies on it.
module RSpec
  # "RSpec specification coverage" is a term we use to go beyond testing.
  module SpecificationCoverage
    # Text-based ruby file details analysis.
    class RubyFileDetails
      # Match method definitions with empty spaces at the beginning.
      REGEXP_METHODS = /\s+def ([a-z_.?]+)/

      # @param file_contents [String]
      def initialize(file_contents)
        @file_contents = file_contents
      end

      # All methods matching regexp except initialize.
      #
      # @return [String]
      def methods
        @methods ||= scan(REGEXP_METHODS)
      end

      private

      # Using external method with "!" methods due to improved performance.
      # @return [String]
      def scan(regexp)
        output = @file_contents.scan(regexp)
        output.flatten!
        output.reject! { |method| method == 'initialize' }
        output.map! { |method| method.gsub(/^self\./, '') }
        output
      end

      private_constant :REGEXP_METHODS
    end
  end
end
