# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rspec'
require_relative '../../app/mailers/application_mailer'

::RSpec.describe(::ApplicationMailer) do
  it { expect(described_class.ancestors).to(include(::ActionMailer::Base)) }
end
