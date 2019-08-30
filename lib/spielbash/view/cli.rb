module Spielbash
  module CLI
    require 'gli'

    include GLI::App
    extend self

    program_desc 'Tool to automate bash movie-making with asciinema. Be the Spielberg of bash'

    desc 'Be verbose'
    switch [:v, :verbose]

    # Cross-platform way of finding an executable in the $PATH.
    #
    #   which('ruby') #=> /usr/bin/ruby
    def which(cmd)
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each {|ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return true if File.executable?(exe) && !File.directory?(exe)
        }
      end
      false
    end

    desc 'Create a recording'
    command :record do |c|
      c.desc 'Script file path'
      c.flag [:script]
      c.desc 'Output file'
      c.flag [:o, :output]

      c.action do |_, options, _|
        script_path = options[:script]
        output_path = options[:output]

        help_now!('pgrep is not installed!') unless which('pgrep')
        help_now!('docker is not installed!') unless which('docker')
        help_now!('tmux is not installed!') unless which('tmux')
        help_now!('resize is not installed!') unless which('resize')
        help_now!('asciinema is not installed!') unless which('asciinema')

        Spielbash::RecordInteractor.new().execute(script_path, output_path)
      end
    end

    exit run(ARGV)
  end
end