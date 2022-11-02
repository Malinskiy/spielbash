module Spielbash
  class TmuxCommandAction < Spielbash::BaseAction
    attr_accessor :command

    def initialize(command, action_context)
      super(action_context)
      @command = command
    end

		def execute(session)
			session.execute_tmux_with(command, action_context.wait)

      sleep(action_context.reading_delay_s)
    end
  end
end