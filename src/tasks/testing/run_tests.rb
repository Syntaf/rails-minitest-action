# frozen_string_literal: true

require_relative './../task'

module Testing
  class RunTests < Task
    def call
      puts 'Running tests...'
      shell('bundle exec rails test')
    end
  end
end
