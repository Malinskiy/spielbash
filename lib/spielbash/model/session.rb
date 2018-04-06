require 'childprocess'
require 'tempfile'
require 'mkmf'

module Spielbash
  class Session
    attr_accessor :context, :name, :output_path
    attr_reader :last_stdout, :last_stderr

    def initialize(name, output_path, context)
      @context = context
      @name = name
      @output_path = output_path

      ChildProcess.posix_spawn = true
    end

    def new_session
      execute_with('resize', "-s #{context.height} #{context.width}", false, false, false)
      execute_tmux_with("new-session -s #{name} -d")
      wait
    end

    def stop_recording
      send_key('C-d')
    end

    def close_session
      send_key("exit")
      send_key('C-m')

      wait
    end

    # This will wait for tmux session pid to not have any child processes
    def wait
      execute_tmux_with('list-panes -F #{pane_pid}' + " -t #{name}", true)
      pid = last_stdout.strip
      return if pid.empty?

      loop do
        execute_with('pgrep', "-P #{pid}", true)
        children = last_stdout
        break if children.empty?
      end
    end

    def send_key(key, count=1)
      key = 'Space' if key == ' '
      execute_tmux_with("send-keys -t #{name} -N #{count} #{key}")
    end

    def start_recording
      execute_tmux_with('list-panes -F #{pane_pid}' + " -t #{name}", true)
      pid = last_stdout.strip
      execute_with('pgrep', "-P #{pid}", true)
      execute_with_exactly('asciinema', false, true, false, "rec", "-y", "-c", "tmux attach -t #{name}", "#{output_path}")
    end

    private

    def execute_tmux_with(arguments, wait = false)
      execute_with('tmux', arguments, wait)
    end

    def execute_with(cmd, arguments, wait = false, leader = true, io_inherit = false)
      args = arguments.split
      execute_with_exactly cmd, wait, io_inherit, leader, *args
    end

    def execute_with_exactly(cmd, wait, io_inherit, leader, *arguments)
      raise "Please install #{cmd}" if which(cmd).nil?

      process = ChildProcess.build(cmd, *arguments)
      process.leader = leader

      if io_inherit
        process.io.inherit!
        process.start
        process.wait if wait
      else
        process.io.stdout, process.io.stderr = std_out_err(cmd)
        process.start
        process.wait if wait
        @last_stdout = output(process.io.stdout)
        @last_stderr = output(process.io.stderr)
      end

      process
    end

    def output(file)
      file.rewind
      out = file.read
      file.close
      file.unlink
      out
    end


    def std_out_err(cmd)
      return ::Tempfile.new(filename_for("#{cmd}-out")), ::Tempfile.new(filename_for("#{cmd}-err"))
    end

    def filename_for(prefix)
      "#{prefix}-#{Time.new.to_s.gsub(' ', '_').gsub(':', '_')}"
    end

    # Cross-platform way of finding an executable in the $PATH.
    #
    #   which('ruby') #=> /usr/bin/ruby
    def which(cmd)
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each {|ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return exe if File.executable?(exe) && !File.directory?(exe)
        }
      end
      return nil
    end
  end
end
