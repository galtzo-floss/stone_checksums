# frozen_string_literal: true

# Load from a "rakelib" directory is automatic!
# Adding this library's custom directory of tasks as a "rakelib"
#   directory makes them available.
abs_path = File.expand_path(__dir__)
rakelib = "#{abs_path}/rakelib"
Rake.add_rakelib(rakelib)
