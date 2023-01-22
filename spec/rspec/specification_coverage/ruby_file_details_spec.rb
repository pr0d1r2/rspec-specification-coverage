# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

require_relative '../../../lib/rspec/specification_coverage/ruby_file_details'

::RSpec.describe(::RSpec::SpecificationCoverage::RubyFileDetails) do
  subject(:details) { described_class.new(file_contents) }

  let(:file_contents) { ::File.read(file_name) }

  around do |example|
    ::Dir.chdir('dummy') do
      example.run
    end
  end

  context 'with helper' do
    let(:file_name) { 'app/helpers/application_helper.rb' }

    it { expect(details.methods).to(contain_exactly('table_cell_class', 'header_class', 'top_header_class')) }
  end

  context 'with lib' do
    let(:file_name) { 'lib/socket_instance.rb' }

    it { expect(details.methods).to(contain_exactly('assign', 'drift', 'empty', 'get', 'unassignable?', 'validate')) }
  end

  describe 'private methods' do
    let(:file_name) { 'lib/ruby_file_details.rb' }

    it '#scan' do
      expect { details.scan }
        .to(raise_error(::NoMethodError, /private method/))
    end

    it { expect(details.__send__(:scan, /(RubyFileDetails)/)).to(contain_exactly('RubyFileDetails')) }
  end
end
