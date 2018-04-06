module Spielbash
  module CLI
    require 'gli'

    include GLI::App
    extend self

    program_desc 'Tool to automate bash movie-making with asciinema. Be the Spielberg of bash'

    desc 'Be verbose'
    switch [:v, :verbose]

    # pre do |global_options, command, options, args|
    # end

    desc 'Create a recording'
    command :record do |c|
      c.desc 'Script file path'
      c.flag [:script]
      c.desc 'Output file'
      c.flag [:o, :output]

      c.action do |_, options, _|
        script_path = options[:script]
        output_path = options[:output]
        Spielbash::RecordInteractor.new().execute(script_path, output_path)
      end
    end

    exit run(ARGV)
  end
end