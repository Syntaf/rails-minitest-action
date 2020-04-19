# frozen_string_literal: true

# Dir.children('/action/rails-minitest-action/services/initializers').each do |f|
#   puts f
# end

require_relative './services/initializers/move_to_workspace'
require_relative './services/initializers/rails_dependency_installer'

require_relative './exceptions/missing_configuration'

STDOUT.sync = true

begin
  Initializers::MoveToWorkspace.call(:GITHUB_WORKSPACE)
  Initializers::RailsDependencyInstaller.call
rescue MissingConfiguration => e
  puts "Missing configuration: #{e.missing_field}"
end
