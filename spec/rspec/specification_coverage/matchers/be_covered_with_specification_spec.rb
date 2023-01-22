# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'

require_relative '../../../../lib/rspec/specification_coverage/matchers/be_covered_with_specification'

::RSpec.describe('be_covered_with_specification matcher') do
  subject(:file) { [dirname, basename].join('/') }

  let(:basename) { 'be_covered_with_specification.rb' }
  let(:dirname) { 'lib/rspec/specification_coverage/matchers' }

  it { is_expected.to(be_covered_with_specification) }

  context 'with dummy' do
    around do |example|
      ::Dir.chdir('dummy') do
        example.run
      end
    end

    describe 'channel' do
      subject(:file) { 'app/channels/application_cable/channel.rb' }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
    end

    describe 'channel connection' do
      subject(:file) { 'app/channels/application_cable/connection.rb' }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
    end

    describe 'controller' do
      subject(:file) { 'app/controllers/application_controller.rb' }

      it { is_expected.to(be_covered_with_specification(type: :requests).with_reflection.spec_bigger.mentioning_methods) }
      it { is_expected.to(be_covered_with_specification(type: :routing).with_reflection.spec_bigger.mentioning_methods) }
    end

    describe 'helper' do
      subject(:file) { 'app/helpers/application_helper.rb' }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
    end

    describe 'job' do
      subject(:file) { 'app/jobs/application_job.rb' }

      it { is_expected.to(be_covered_with_specification.with_reflection.mentioning_methods) }
    end

    describe 'mailer' do
      subject(:file) { 'app/mailers/application_mailer.rb' }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
    end

    describe 'model' do
      subject(:file) { 'app/models/application_record.rb' }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
    end

    describe 'view' do
      subject(:file) { 'app/views/layouts/application.html.erb' }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
    end
  end

  context 'with dummy using globbing' do
    around do |example|
      ::Dir.chdir('dummy') do
        example.run
      end
    end

    ::Dir['dummy/app/**/*.rb'].reject { |a_file| a_file.start_with?('dummy/app/controllers') }
                              .each do |a_file|
      describe a_file do
        subject(:file) { a_file.gsub(%r{^dummy/}, '') }

        it { is_expected.to(be_covered_with_specification.with_reflection) }
      end
    end
  end

  describe 'invalid helper usage' do
    subject(:use) { expect(file).to(be_covered_with_specification.with_reflection) }

    context 'with not existing file' do
      let(:file) { 'lib/not_existing.rb' }

      specify do
        expect { use }
          .to(raise_error(::RSpec::Expectations::ExpectationNotMetError))
      end
    end

    context 'with non-string' do
      let(:file) { :non_string }

      specify do
        expect { use }
          .to(raise_error(::ArgumentError))
      end
    end
  end
end
