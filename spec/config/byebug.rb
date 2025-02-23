if ENV.fetch("DEBUG", "false").casecmp("true") == 0
  if VersionGem::Ruby.gte_minimum_version?("2.7")
    require "debug"
  else
    require "byebug"
  end
end
