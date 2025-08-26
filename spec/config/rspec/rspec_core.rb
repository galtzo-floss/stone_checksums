RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    # You can add further configurations for rspec-mocks here,
    # for example, to enforce strict verification of partial doubles:
    mocks.verify_partial_doubles = true
  end
end
