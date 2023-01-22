# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'active_record'

# Top-level application record all models inherit from.
class ApplicationRecord < ::ActiveRecord::Base
  primary_abstract_class
end
