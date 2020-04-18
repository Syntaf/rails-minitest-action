# frozen_string_literal: true

# Dir.children('/action/rails-minitest-action/services/initializers').each do |f|
#   puts f
# end

require_relative './services/initializers/move_to_workspace'
require_relative './services/initializers/dependency_installer'

require_relative './exceptions/missing_configuration'

begin
  Initializers::MoveToWorkspace.call(:GITHUB_WORKSPACE)
rescue MissingConfiguration => e
  puts "Missing configuration: #{e.missing_field}"
end
