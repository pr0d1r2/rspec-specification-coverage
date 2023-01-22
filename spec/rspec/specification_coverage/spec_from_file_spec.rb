# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

require_relative '../../../lib/rspec/specification_coverage/spec_from_file'

::RSpec.describe(::RSpec::SpecificationCoverage::SpecFromFile) do
  subject { described_class.is(file, type) }

  let(:file) { 'app/models/user.rb' }
  let(:type) { nil }

  it { is_expected.to(eq('spec/models/user_spec.rb')) }

  context 'with lib' do
    let(:file) { 'lib/user_stuff.rb' }

    it { is_expected.to(eq('spec/user_stuff_spec.rb')) }

    context 'when type is lib' do
      let(:type) { :lib }

      it { is_expected.to(eq('spec/lib/user_stuff_spec.rb')) }
    end
  end

  context 'with view' do
    let(:file) { 'app/views/layouts/application.html.erb' }

    it { is_expected.to(eq('spec/views/layouts/application.html.erb_spec.rb')) }
  end

  context 'with controller' do
    let(:file) { 'app/controllers/application_controller.rb' }

    it { is_expected.to(eq('spec/controllers/application_controller_spec.rb')) }

    context 'when type is routing' do
      let(:type) { :routing }

      it { is_expected.to(eq('spec/routing/application_routing_spec.rb')) }
    end

    context 'when type is requests' do
      let(:type) { :requests }

      it { is_expected.to(eq('spec/requests/application_spec.rb')) }
    end
  end

  describe 'private interface' do
    subject(:instance) { described_class.new(file, type) }

    it 'has private #controller_replaced' do
      expect { instance.controller_replaced }
        .to(raise_error(::NoMethodError, /private method/))
    end

    it 'has private #app_replaced' do
      expect { instance.app_replaced }
        .to(raise_error(::NoMethodError, /private method/))
    end

    it 'has private #valid?' do
      expect { instance.valid? }
        .to(raise_error(::NoMethodError, /private method/))
    end
  end
end
