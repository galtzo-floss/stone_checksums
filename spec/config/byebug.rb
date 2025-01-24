require "byebug" if VersionGem::Ruby.gte_minimum_version?("2.7") && ENV.fetch("DEBUG", "false").casecmp?("true")
