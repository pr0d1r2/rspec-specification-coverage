# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'
require 'singleton'

require_relative '../../lib/socket_instance'

::RSpec.describe(::SocketInstance) do
  let(:instance) { described_class.instance }

  let(:threads) { 8 }

  let(:number)       { 1    }
  let(:first_is_one) { true }

  before do
    stub_const("#{described_class}::THREADS", threads)

    stub_const("#{described_class}::NUMBER", number)
    stub_const("#{described_class}::FIRST_IS_ONE", first_is_one)
  end

  it { expect(described_class.ancestors).to(include(::Singleton)) }

  it { expect(instance.get(60_000)).to(eq(60_000)) }

  describe 'errors' do
    it 'raises error without arguments' do
      expect { instance.get }
        .to(raise_error(::ArgumentError))
    end

    it 'raises error on string' do
      expect { instance.get('1') }
        .to(raise_error(::ArgumentError))
    end

    it 'raises error on string which would be a valid low port' do
      expect { instance.get('1025') }
        .to(raise_error(::ArgumentError))
    end

    it 'raises error on string which would be a valid high port' do
      expect { instance.get('60000') }
        .to(raise_error(::ArgumentError))
    end

    it 'raises error on string which is below low port' do
      expect { instance.get(1024) }
        .to(raise_error(::ArgumentError))
    end

    it 'raises error on string which is above high port' do
      expect { instance.get(65_536) }
        .to(raise_error(::ArgumentError))
    end

    context 'when there is overlap with already requested range' do
      let(:number) { 0 }
      let(:first_is_one) { nil }

      before { instance.get(60_020) }

      it 'raises error' do
        expect { instance.get(60_020) }
          .to(raise_error(::ArgumentError))
      end
    end

    context 'when there is non-obvious overlap with already requested range' do
      let(:number) { 0 }
      let(:first_is_one) { nil }

      before { instance.get(60_030) }

      it 'raises error' do
        expect { instance.get(60_034) }
          .to(raise_error(::ArgumentError, /60030/))
      end
    end
  end

  context 'when there is no number and is not one' do
    let(:number) { 0 }
    let(:first_is_one) { nil }

    it { expect(instance.get(60_010)).to(eq(60_010)) }
  end

  describe 'constants in implementation' do
    subject(:implementation) { ::File.read(file) }

    let(:file) { 'lib/socket_instance.rb' }

    it { is_expected.to(have_private_constant(:THREADS)) }
    it { is_expected.to(have_private_constant(:NUMBER)) }
    it { is_expected.to(have_private_constant(:FIRST_IS_ONE)) }
    it { is_expected.to(have_private_constant(:START_PORT)) }
    it { is_expected.to(have_private_constant(:END_PORT)) }

    def have_private_constant(name)
      match(/^  private_constant :#{name}$/)
    end
  end

  describe '#empty' do
    context 'when there is overlap with already requested range' do
      let(:number)       { 0   }
      let(:first_is_one) { nil }

      before do
        instance.get(60_050)
        instance.get(60_060)
      end

      it 'allows emptying instance and asking for the same ranges again' do
        instance.empty

        expect(instance.get(60_050)).to(eq(60_050))
        expect(instance.get(60_060)).to(eq(60_060))
      end
    end
  end

  describe 'private methods' do
    it '#validate' do
      expect { instance.validate }
        .to(raise_error(::NoMethodError, /private method/))
    end

    it '#drift' do
      expect { instance.drift }
        .to(raise_error(::NoMethodError, /private method/))
    end

    it '#unassignable?' do
      expect { instance.unassignable? }
        .to(raise_error(::NoMethodError, /private method/))
    end

    it '#assign' do
      expect { instance.assign }
        .to(raise_error(::NoMethodError, /private method/))
    end
  end
end
