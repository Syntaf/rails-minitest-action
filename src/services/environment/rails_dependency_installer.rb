# frozen_string_literal: true

require 'pty'
require_relative './../service'

module Environment 
  class RailsDependencyInstaller < Service
    def call
      `bundle config path vendor/bundle && \
       bundle config --local build.sassc --disable-march-tune-native`

      PTY.spawn('bundle install --jobs 4 --retry 3') do |stdout, _stdin, _pid|
        puts 'Installing dependencies...'
        stdout.each { |line| puts line }
      end
    rescue PTY::ChildExited, Errno::EIO
      puts 'Installation complete'
    end
  end
end
