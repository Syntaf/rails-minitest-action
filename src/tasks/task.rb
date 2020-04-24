# frozen_string_literal: true

# rubocop:disable Lint/SuppressedException

require 'pty'

class Task
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def shell(cmd)
    PTY.spawn(cmd) do |stdout, _stdin, _pid|
      stdout.each { |line| puts line }

      Process.wait(_pid)
    end
  rescue PTY::ChildExited, Errno::EIO
  end
end

# rubocop:enable Lint/SuppressedException
