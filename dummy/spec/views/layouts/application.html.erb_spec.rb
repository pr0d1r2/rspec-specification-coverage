# Copyright (c) 2023 by Marcin Nowicki
# frozen_string_literal: true

require 'rails_helper'
require 'rspec'

::RSpec.describe('layouts/application') do
  subject { rendered }

  before do
    allow(view).to(receive(:render).and_call_original)
    allow(view).to(receive(:render).with('sidebar').and_return('SIDEBAR'))
    allow(view).to(receive(:csrf_meta_tags).and_return('CSRF_META_TAGS'))
    allow(view).to(receive(:csp_meta_tag).and_return('CSP_META_TAG'))
    allow(view).to(receive(:javascript_importmap_tags).and_return('JAVASCRIPT_IMPORTMAP_TAGS'))
    render
  end

  it { is_expected.to(include('CSRF_META_TAGS')) }
  it { is_expected.to(include('CSP_META_TAG')) }
  it { is_expected.to(include('JAVASCRIPT_IMPORTMAP_TAGS')) }
  it { is_expected.to(include('SIDEBAR')) }
end
