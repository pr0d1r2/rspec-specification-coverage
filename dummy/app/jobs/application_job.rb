# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'active_job'

# Base application job.
class ApplicationJob < ::ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
