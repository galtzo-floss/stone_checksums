if ENV.fetch("DEBUG", "false").casecmp?("true")
  if VersionGem::Ruby.gte_minimum_version?("2.7")
    require "debug"
  else
    require "byebug"
  end
end
