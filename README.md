# rspec-specification-coverage

Allow specify coverage of files.

## Why

Allow specify the way RSpec files cover the implementation.

### Why such long name

There is a common misconception in the community that RSpec is mainly
about testing - where it is mostly about specifying with ability to run
that specification. Well written specification makes most documentation
redundant - by reading the specification you should understand the
implementation.

## Usage

### Install

Add following to your Gemfile:

```ruby
group :test do
  gem 'rspec-specification-coverage', '~> 0.1', require: false
end
```

And run:

```bash
bundle install
```

### Basic

Ensures is respective spec file existing for implementation.

The following will ensure that `spec/models/user_spec.rb` file exist:

```ruby
require 'rspec/specification_coverage'

::RSpec.describe(::RSpec::SpecificationCoverage) do
  subject(:file) { 'app/models/user.rb' }

  it { is_expected.to(be_covered_with_specification) }
end
```

### With Reflection

The following will ensure that in case there are git changes to
`app/models/user.rb`, respective specification in
`spec/models/user_spec.rb` also needs to be updated:

```ruby
it { is_expected.to(be_covered_with_specification.with_reflection) }
```

### Spec Bigger

The following will ensure that `spec/models/user_spec.rb`
file is bigger than `app/models/user.rb`.

```ruby
it { is_expected.to(be_covered_with_specification.spec_bigger) }
```

### Mentioning Methods

The following will ensure that `spec/models/user_spec.rb`
file include method names from `app/models/user.rb`.

```ruby
it { is_expected.to(be_covered_with_specification.mentioning_methods) }
```

### All

We can mix all above ways together:

```ruby
it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
```

## Real Life Example

The following is a running example in one of my projects:

```ruby
# frozen_string_literal: true

require 'rspec'
require 'rspec/specification_coverage'

::RSpec.describe(::RSpec::SpecificationCoverage) do
  ::Dir.glob('app/{helpers,models,channels,mailers}/**/*.rb').each do |a_file|
    describe a_file do
      subject(:file) { a_file }

      it { is_expected.to(be_covered_with_specification.with_reflection.spec_bigger.mentioning_methods) }
    end
  end

  ::Dir.glob('app/jobs/**/*.rb').each do |a_file|
    describe a_file do
      subject(:file) { a_file }

      it { is_expected.to(be_covered_with_specification.with_reflection) }
    end
  end

  ::Dir.glob('app/views/**/*.erb').each do |a_file|
    describe a_file do
      subject(:file) { a_file }

      it { is_expected.to(be_covered_with_specification.with_reflection) }
    end
  end

  ::Dir.glob('lib/**/*.rb').each do |a_file|
    describe a_file do
      subject(:file) { a_file }

      it { is_expected.to(be_covered_with_specification(type: :lib).with_reflection.mentioning_methods) }
    end
  end

  ::Dir.glob('app/controllers/**/*.rb').each do |a_file|
    describe a_file do
      subject(:file) { a_file }

      it {
        is_expected.to(
          be_covered_with_specification(type: :requests).with_reflection.spec_bigger.mentioning_methods
        )
      }

      it {
        is_expected.to(
          be_covered_with_specification(type: :routing).with_reflection.mentioning_methods
        )
      }
    end
  end
end
```

## Development

We use TDD on Guard.

### Setup

```bash
bash util/setup.sh
```

### Check if overcommit is operational

```bash
bash util/overcommit_spec.sh
```

### Run your TDD reactor

```bash
bundle exec guard
```
