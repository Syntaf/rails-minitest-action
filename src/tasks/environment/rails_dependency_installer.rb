# frozen_string_literal: true

require_relative './../task'

module Environment
  class RailsDependencyInstaller < Task
    def call
      puts 'Installing dependencies'

      configure_cache_friendly_install

      shell('bundle install --jobs 4 --retry 3')
    end

    private

    def configure_cache_friendly_install
      shell('bundle config path vendor/bundle && \
        bundle config --local build.sassc --disable-march-tune-native')
    end
  end
end
