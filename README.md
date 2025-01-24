# GemChecksums

A ruby script, and rake task, to generate SHA-256 and SHA-512 checksums of RubyGem libraries, shipped as a RubyGem.

## Installation

Install the gem and add to the gem's Gemfile by executing:

```bash
bundle add gem_checksums
```

Or add it as a development dependency to the gemspec:

```ruby
Gem::Specification.new do |spec|
  # ...
  spec.add_development_dependency("gem_checksums", "~> 1.0")
end
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install gem_checksums
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gem_checksums. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/gem_checksums/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GemChecksums project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gem_checksums/blob/main/CODE_OF_CONDUCT.md).
