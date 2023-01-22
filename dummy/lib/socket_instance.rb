# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'etc'
require 'singleton'

# Prevents overlap on multiple port ranges.
class SocketInstance
  include ::Singleton

  # Number of processing threads.
  THREADS = ::Etc.nprocessors

  # Thread number
  NUMBER = ::ENV.fetch('TEST_ENV_NUMBER', 0).to_i
  # Used to calculate drift.
  FIRST_IS_ONE = ::ENV.fetch('PARALLEL_TEST_FIRST_IS_1', false)

  # Ports below start port require root.
  START_PORT = 1_024
  # last possible start port.
  END_PORT = 65_535 - THREADS

  # Initialize empty instance.
  def initialize
    empty
  end

  # @param start_port [Integer]
  # @return [Integer]
  def get(start_port)
    validate(start_port)

    assign(start_port)

    start_port + NUMBER + drift
  end

  # Reset singleton instance values.
  # @return [Array[Integer]]
  def empty
    @ranges = []
  end

  private

  attr_reader :ranges

  # @param start_port [Integer]
  # @return [nil]
  # @raise [ArgumentError]
  def validate(start_port)
    raise(::ArgumentError) unless start_port.is_a?(::Integer)
    raise(::ArgumentError) unless start_port > START_PORT
    raise(::ArgumentError) unless start_port < END_PORT
    raise(::ArgumentError, ranges.inspect) if unassignable?(start_port)
  end

  # @return [Integer]
  def drift
    if FIRST_IS_ONE
      -1
    else
      0
    end
  end

  # @param start_port [Integer]
  # @return [Boolean]
  def unassignable?(start_port)
    ranges.any? do |range_start|
      (range_start..(range_start + THREADS)).cover?(start_port)
    end
  end

  # @param start_port [Integer]
  # @return [Array[Integer]]
  def assign(start_port)
    @ranges << start_port
  end

  private_constant :THREADS
  private_constant :NUMBER
  private_constant :FIRST_IS_ONE
  private_constant :START_PORT
  private_constant :END_PORT
end
