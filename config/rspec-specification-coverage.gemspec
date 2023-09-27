# frozen_string_literal: true

::Gem::Specification.new do |s|
  s.name = 'rspec-specification-coverage'
  s.version = '0.1.2'
  s.required_ruby_version = '~> 3.1'
  s.licenses = ['MIT']
  s.summary = 'Specify RSpec specification coverage.'
  s.description = 'Allow specify how RSpec specification files cover the implementation.'
  s.authors = ['Marcin Nowicki']
  s.email = 'pr0d1r2@gmail.com'
  s.files = %w[
    lib/rspec-specification-coverage.rb
    lib/rspec/specification_coverage.rb
    lib/rspec/specification_coverage/git_files_changed.rb
    lib/rspec/specification_coverage/matchers/be_covered_with_specification.rb
    lib/rspec/specification_coverage/ruby_file_details.rb
    lib/rspec/specification_coverage/spec_from_file.rb
  ]
  s.extra_rdoc_files = %w[
    LICENSE.md
    README.md
  ]
  s.homepage = 'https://github.com/pr0d1r2/rspec-specification-coverage'
  s.metadata = {
    'source_code_uri' => 'https://github.com/pr0d1r2/rspec-specification-coverage',
    'rubygems_mfa_required' => 'true'
  }

  s.require_paths = ['lib']

  s.add_runtime_dependency('activesupport', '~> 7')
  s.add_runtime_dependency('nokogiri', '~> 1.14.3')

  s.add_development_dependency('alfonsox', '~> 0.2')
  s.add_development_dependency('bundle-audit', '~> 0.1')
  s.add_development_dependency('guard', '~> 2.18')
  s.add_development_dependency('guard-rspec', '~> 4.7')
  s.add_development_dependency('guard-rubocop', '~> 1.5')
  s.add_development_dependency('guard-yard', '~> 2.2')
  s.add_development_dependency('mdl', '~> 0.12')
  s.add_development_dependency('overcommit', '~> 0.60')
  s.add_development_dependency('parallel_tests', '~> 4.0')
  s.add_development_dependency('rake', '~> 13.0.6')
  s.add_development_dependency('reek', '~> 6.1')
  s.add_development_dependency('rspec', '~> 3.12')
  s.add_development_dependency('rubocop', '~> 1.41')
  s.add_development_dependency('rubocop-performance', '~> 1.15')
  s.add_development_dependency('rubocop-require_tools', '~> 0.1')
  s.add_development_dependency('rubocop-rspec', '~> 2.16')
  s.add_development_dependency('rubocop-thread_safety', '~> 0.4')
  s.add_development_dependency('simplecov', '~> 0.22')
end
