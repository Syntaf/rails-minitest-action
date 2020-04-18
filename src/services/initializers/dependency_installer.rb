# frozen_string_literal: true

require_relative './../service'

module Initializers
  class DependencyInstaller < Service
    def call
      `gem install bundler`
    end
  end
end
