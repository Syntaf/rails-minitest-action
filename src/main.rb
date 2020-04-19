# frozen_string_literal: true

require_relative './services/environment/move_to_workspace'
require_relative './services/environment/rails_dependency_installer'
require_relative './services/database/create_test_database'
require_relative './services/database/migrate_test_database'

require_relative './exceptions/missing_configuration'

STDOUT.sync = true

begin
  Environment::MoveToWorkspace.call(:GITHUB_WORKSPACE)
  Environment::RailsDependencyInstaller.call

  Database::CreateTestDatabase.call
  Database::MigrateTestDatabase.call
rescue MissingConfiguration => e
  puts "Missing configuration: #{e.missing_field}"
end
