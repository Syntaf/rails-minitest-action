# frozen_string_literal: true

# rubocop:disable Lint/SuppressedException

require 'pty'

class Task
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def shell(cmd)
    begin
      PTY.spawn(cmd) do |stdout, _stdin, pid|
        stdout.each { |line| puts line }
      rescue Errno::EIO
      ensure
        Process.wait(pid)
      end
    rescue PTY::ChildExited
    end

    $?.exitstatus
  end
end

# rubocop:enable Lint/SuppressedException
