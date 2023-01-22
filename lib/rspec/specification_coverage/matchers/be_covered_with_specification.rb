# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'rspec'
require_relative '../spec_from_file'

::RSpec::Matchers.define(:be_covered_with_specification) do |type: nil|
  match do |actual|
    @spec_file = ::RSpec::SpecificationCoverage::SpecFromFile.is(actual, type)

    return false unless ::File.exist?(@spec_file)

    if @spec_bigger || @mentioning_methods
      if ::File.exist?(actual)
        file_contents = ::File.read(actual)
        @file_size = file_contents.size
      else
        file_contents = nil
        @file_size = 0
      end
      if ::File.exist?(@spec_file)
        spec_contents = ::File.read(@spec_file)
        @spec_size = spec_contents.size
      else
        spec_contents = nil
        @spec_size = 0
      end
    end

    if @spec_bigger
      @spec_is_bigger = @spec_size > @file_size

      return false unless @spec_is_bigger
    end

    if @with_reflection
      require_relative '../git_files_changed'
      file_changed = ::RSpec::SpecificationCoverage::GitFilesChanged.instance.include?(actual)

      if file_changed
        @have_reflection = ::RSpec::SpecificationCoverage::GitFilesChanged.instance.include?(@spec_file)

        return false unless @have_reflection
      end
    end

    if @mentioning_methods && @file_size.positive? && @spec_size.positive?
      @missing_methods = []

      require_relative '../ruby_file_details'
      file_details = ::RSpec::SpecificationCoverage::RubyFileDetails.new(file_contents)
      file_details.methods.each do |method|
        @missing_methods << method unless spec_contents.include?(method)
      end

      return false if @missing_methods.present?
    end

    true
  end

  failure_message do |actual|
    message = "expected that '#{actual}'\n"
    message += "would have respective spec '#{@spec_file}'\n"
    if @spec_bigger && @spec_is_bigger == false
      message += "which is bigger than the implementation (#{@spec_size} > #{@file_size})\n"
    end
    if @with_reflection && @have_reflection == false
      message += "in case you change '#{actual}' then you have to specify it in '#{@spec_file}'\n"
    end
    if @mentioning_methods && @missing_methods.present?
      message += 'the spec is missing mention of following methods: '
      message += @missing_methods.join(', ')
    end
    message
  end

  chain :with_reflection do
    @with_reflection = true
  end

  chain :spec_bigger do
    @spec_bigger = true
  end

  chain :mentioning_methods do
    @mentioning_methods = true
  end
end
