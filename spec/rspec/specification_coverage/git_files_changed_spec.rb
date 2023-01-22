# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'
require 'singleton'

require_relative '../../../lib/rspec/specification_coverage/git_files_changed'

::RSpec.describe(::RSpec::SpecificationCoverage::GitFilesChanged) do
  let(:instance) { described_class.instance }

  let(:all) { [first, second] }
  let(:first)  { 'lib/rspec/specification_coverage/git_files_changed.rb'           }
  let(:second) { 'spec/lib/rspec/specification_coverage/git_files_changed_spec.rb' }

  before { stub_const("#{described_class}::ALL", all) }

  it { expect(described_class.ancestors).to(include(::Singleton)) }

  it { expect(instance).to(include(first)) }
  it { expect(instance).to(include(second)) }
  it { expect(instance).not_to(include('not_changed.rb')) }

  describe 'constants in implementation' do
    subject(:implementation) { ::File.read(file) }

    let(:file) { first }

    it { is_expected.to(have_private_constant(:ALL)) }

    def have_private_constant(name)
      match(/^      private_constant :#{name}$/)
    end
  end
end
