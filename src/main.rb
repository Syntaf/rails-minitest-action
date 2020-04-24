# frozen_string_literal: true

require_relative './tasks/environment/move_to_workspace'
require_relative './tasks/environment/rails_dependency_installer'
require_relative './tasks/database/create_test_database'
require_relative './tasks/database/migrate_test_database'
require_relative './tasks/testing/run_tests'

require_relative './exceptions/missing_configuration'

STDOUT.sync = true

begin
  Environment::MoveToWorkspace.call(:GITHUB_WORKSPACE)
  Environment::RailsDependencyInstaller.call

  Database::CreateTestDatabase.call
  Database::MigrateTestDatabase.call

  exit Testing::RunTests.call
rescue MissingConfiguration => e
  puts "Missing configuration: #{e.missing_field}"
end
