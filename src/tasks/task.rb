# frozen_string_literal: true

# rubocop:disable Lint/SuppressedException

require 'English'
require 'pty'

class Task
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def shell(cmd)
    begin
      PTY.spawn(cmd) do |stdout, _stdin, pid|
        stdout.each { |line| puts line }

        Process.wait(pid)
      end
    rescue PTY::ChildExited, Errno::EIO
      # no-op for non-fatal exceptions
    end

    $CHILD_STATUS.exitstatus
  end
end

# rubocop:enable Lint/SuppressedException
