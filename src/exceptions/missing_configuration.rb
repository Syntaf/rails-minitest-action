# frozen_string_literal: true

class MissingConfiguration < StandardError
  attr_reader :missing_field

  def initialize(missing_field)
    @missing_field = missing_field
  end
end
