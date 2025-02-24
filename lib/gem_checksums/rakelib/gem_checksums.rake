# TODO: Override rake build task with check for SOURCE_DATE_EPOCH environment variable, and raise error if not set.

namespace :build do
  desc "Generate both SHA256 & SHA512 checksums into the checksums directory, and git commit them"
  task :generate_checksums do
    GemChecksums.generate
  end
end
