# frozen_string_literal: true

require 'English'

require_relative './../task'

module Testing
  class RunTests < Task
    def call
      puts 'Running tests...'
      shell('bundle exec rails test')
      $CHILD_STATUS.exitstatus
    end
  end
end
