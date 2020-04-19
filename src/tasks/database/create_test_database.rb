# frozen_string_literal: true

require_relative './../task'
require_relative './../../exceptions/missing_configuration'

module Database
  class CreateTestDatabase < Task
    def call
      puts 'Beginning database setup...'
      drop_existing_database
      create_fresh_database
    end

    private

    def drop_existing_database
      shell('bundle exec rails db:drop RAILS_ENV=test')
    end

    def create_fresh_database
      shell('bundle exec rails db:create RAILS_ENV=test')
    end
  end
end
