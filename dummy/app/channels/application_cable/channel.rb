# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'action_cable'

# Base action cable module.
module ApplicationCable
  # Base application action cable channel.
  class Channel < ::ActionCable::Channel::Base
  end
end
