namespace :build do
  desc "Generate both SHA256 & SHA512 checksums into the checksums directory, and git commit them"
  task :checksums do
    GemChecksums.generate
  end
end
