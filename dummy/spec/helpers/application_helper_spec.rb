# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require_relative '../../app/helpers/application_helper'

require 'rails_helper'
require 'rspec'

::RSpec.describe(::ApplicationHelper) do
  describe 'included modules' do
    it { expect(described_class.ancestors).to(include(::BetterHtml::Helpers)) }
  end

  describe '#table_cell_class' do
    subject(:table_cell_class) { helper.table_cell_class }

    it { is_expected.to(include('w-1/2')) }
    it { is_expected.to(include('border')) }
    it { is_expected.to(include('border-slate-300')) }
    it { is_expected.to(include('dark:border-slate-600')) }
    it { is_expected.to(include('font-semibold')) }
    it { is_expected.to(include('p-4')) }
    it { is_expected.to(include('text-slate-900')) }
    it { is_expected.to(include('dark:text-slate-200')) }
    it { is_expected.to(include('text-left')) }

    describe 'amount' do
      subject(:table_cell_class) { helper.table_cell_class.split.size }

      it { is_expected.to(eq(9)) }
    end
  end

  shared_examples 'base header' do
    it { is_expected.to(include('inline-block')) }
    it { is_expected.to(include('font-extrabold')) }
    it { is_expected.to(include('text-slate-900')) }
    it { is_expected.to(include('tracking-tight')) }
    it { is_expected.to(include('dark:text-slate-200')) }
  end

  describe '#header_class' do
    subject(:header_class) { helper.header_class }

    it_behaves_like 'base header'

    it { is_expected.to(include('text-3xl')) }
    it { is_expected.to(include('sm:text-3l')) }

    describe 'amount' do
      subject(:table_cell_class) { helper.header_class.split.size }

      it { is_expected.to(eq(7)) }
    end
  end

  describe '#top_header_class' do
    subject(:top_header_class) { helper.top_header_class }

    it_behaves_like 'base header'

    it { is_expected.to(include('text-5xl')) }
    it { is_expected.to(include('sm:text-5xl')) }

    describe 'amount' do
      subject(:table_cell_class) { helper.top_header_class.split.size }

      it { is_expected.to(eq(7)) }
    end
  end

  describe 'constants' do
    subject(:implementation) { ::File.read(file) }

    let(:file) { 'app/helpers/application_helper.rb' }

    it { is_expected.to(have_private_constant(:TABLE_CELL_CLASS)) }
    it { is_expected.to(have_private_constant(:HEADER_CLASS)) }
    it { is_expected.to(have_private_constant(:TOP_HEADER_CLASS)) }

    def have_private_constant(name)
      match(/^  private_constant :#{name}$/)
    end
  end
end
