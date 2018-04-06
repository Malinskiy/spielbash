require 'simplecov'
require 'bundler/setup'
require 'spielbash/spielbash'

module FileFixtures
  def file_fixture(fixture_name)
    path = Pathname.new(File.join('spec/fixtures/files', fixture_name))

    if path.exist?
      path
    else
      msg = "the directory '%s' does not contain a file named '%s'"
      raise ArgumentError, msg % ['spec/fixtures/files', fixture_name]
    end
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include(FileFixtures)
end