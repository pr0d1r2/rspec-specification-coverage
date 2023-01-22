# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

# General application helpers
module ApplicationHelper
  # Table cell CSS classes
  TABLE_CELL_CLASS = %w[
    text-left
  ].join(' ').freeze

  # Header CSS classes
  HEADER_CLASS = %w[
    inline-block
    text-3xl
  ].join(' ').freeze

  # Top header CSS classes
  TOP_HEADER_CLASS = %w[
    inline-block
    text-5xl
  ].join(' ').freeze

  # @return [String]
  def table_cell_class
    TABLE_CELL_CLASS
  end

  # @return [String]
  def header_class
    HEADER_CLASS
  end

  # @return [String]
  def top_header_class
    TOP_HEADER_CLASS
  end

  private_constant :TABLE_CELL_CLASS
  private_constant :HEADER_CLASS
  private_constant :TOP_HEADER_CLASS
end
