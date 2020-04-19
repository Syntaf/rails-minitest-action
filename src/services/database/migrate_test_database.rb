# frozen_string_literal: true

# rubocop:disable Lint/SuppressedException

require 'pty'
require_relative './../service'

module Database
  class MigrateTestDatabase < Service
    def call
      puts 'Migrating database....'
      cmd = 'bundle exec rails db:migrate RAILS_ENV=test'
      PTY.spawn(cmd) do |stdout, _stdin, _pid|
        stdout.each { |line| puts line }
      end
    rescue PTY::ChildExited, Errno::EIO
    end
  end
end

# rubocop:enable Lint/SuppressedException
