# frozen_string_literal: true

# rubocop:disable Lint/SuppressedException

require 'pty'
require_relative './../service'
require_relative './../../exceptions/missing_configuration'

module Database
  class CreateTestDatabase < Service
    def call
      puts 'Beginning database setup...'
      drop_existing_database
      create_fresh_database
    end

    private

    def drop_existing_database
      cmd = 'bundle exec rails db:drop RAILS_ENV=test'
      PTY.spawn(cmd) do |stdout, _stdin, _pid|
        stdout.each { |line| puts line }
      end
    rescue PTY::ChildExited, Errno::EIO
    end

    def create_fresh_database
      cmd = 'bundle exec rails db:create RAILS_ENV=test'
      PTY.spawn(cmd) do |stdout, _stdin, _pid|
        stdout.each { |line| puts line }
      end
    rescue PTY::ChildExited, Errno::EIO
    end
  end
end

# rubocop:enable Lint/SuppressedException
