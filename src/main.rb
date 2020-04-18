# frozen_string_literal: true

# Dir.children('/action/rails-minitest-action/services/initializers').each do |f|
#   puts f
# end

require_relative './services/initializers/directory_changer'
require_relative './services/initializers/dependency_installer'

Initializers::DirectoryChanger.call(ENV['GITHUB_WORKSPACE'])
# DependencyInstaller.call
