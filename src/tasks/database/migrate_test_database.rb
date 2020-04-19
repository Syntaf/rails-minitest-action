# frozen_string_literal: true

require 'pty'
require_relative './../task'

module Database
  class MigrateTestDatabase < Task
    def call
      puts 'Migrating database....'
      shell('bundle exec rails db:migrate RAILS_ENV=test')
    end
  end
end
