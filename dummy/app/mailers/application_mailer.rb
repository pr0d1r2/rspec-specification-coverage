# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'action_mailer'

# Top-level application mailer all mailers inherit from.
class ApplicationMailer < ::ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
