# frozen_string_literal: true

class Service
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
