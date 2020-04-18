# frozen_string_literal: true

require_relative './../service'
require_relative './../../exceptions/missing_configuration'

module Initializers
  class DirectoryChanger < Service
    def initialize(directory)
      @target_directory = directory
    end

    def call
      raise MissingConfiguration if @target_directory.nil?

      Dir.chdir @target_directory
    end
  end
end
