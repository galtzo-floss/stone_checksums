# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in gem_checksums.gemspec
gemspec

### Std Lib Extracted Gems
gem "mutex_m", "~> 0.2"
gem "stringio", "~> 3.1", ">= 3.1.2"
gem "benchmark", "~> 0.4"

platform :mri do
  ### Debugging (MRI Only)
  gem "byebug", ">= 11"
end

gem "appraisal", github: "pboling/appraisal", branch: "galtzo"
