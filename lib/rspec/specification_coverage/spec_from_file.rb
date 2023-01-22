# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

# We store it within rspec as it relies on it.
module RSpec
  # "RSpec specification coverage" is a term we use to go beyond testing.
  module SpecificationCoverage
    # Allows getting getting spec name from file name.
    class SpecFromFile
      # @param actual [String] for example `app/models/user.rb`
      # @param type [Symbol] the type, `nil`, `:routing`, `:requests`, `:lib`
      def self.is(actual, type)
        new(actual, type).is
      end

      # @param actual [String] for example `app/models/user.rb`
      # @param type [Symbol] the type, `nil`, `:routing`, `:requests`, `:lib`
      def initialize(actual, type)
        @actual = actual
        @type = type

        raise(::ArgumentError) unless valid?
      end

      # @return [String] like `spec/models/user_spec.rb`
      def is
        case @type
        when :routing
          controller_replaced.gsub(/\.rb$/, "_#{@type}_spec.rb")
        when :requests
          controller_replaced.gsub(/\.rb$/, '_spec.rb')
        when :lib
          suffix_replaced.gsub(/^lib/, 'spec/lib')
        else
          suffix_replaced.gsub(/^lib/, 'spec')
        end
      end

      private

      # @return [String]
      def controller_replaced
        app_replaced.gsub('_controller.', '.').gsub(%r{/controllers/}, "/#{@type}/")
      end

      # @return [String]
      def app_replaced
        @actual.gsub(/^app/, 'spec')
      end

      # @return [String]
      def suffix_replaced
        app_replaced.gsub(/\.rb$/, '_spec.rb').gsub(/\.erb$/, '.erb_spec.rb')
      end

      # @return [Boolean]
      def valid?
        @actual.is_a?(::String) && (@type.is_a?(::Symbol) || @type.is_a?(::NilClass))
      end
    end
  end
end
