# frozen_string_literal: true

require_relative './../task'
require_relative './../../exceptions/missing_configuration'

module Environment
  class MoveToWorkspace < Task
    def initialize(environment_key)
      @environment_key = environment_key
    end

    def call
      if ENV[@environment_key.to_s].nil?
        raise MissingConfiguration, @environment_key
      end

      Dir.chdir ENV[@environment_key.to_s]
    end
  end
end
