# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'action_cable'

module ApplicationCable
  # Base application action cable connection.
  class Connection < ::ActionCable::Connection::Base
  end
end
