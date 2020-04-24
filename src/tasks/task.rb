# frozen_string_literal: true

# rubocop:disable Lint/SuppressedException

require 'pty'

class Task
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def shell(cmd)
    PTY.spawn(cmd) do |stdout, _stdin, pid|
      stdout.each { |line| puts line }

      Process.wait(pid)
    end
  rescue PTY::ChildExited, Errno::EIO
    # non-fatal exit exceptions, no-op
  ensure
    $CHILD_STATUS.exitstatus
  end
end

# rubocop:enable Lint/SuppressedException
