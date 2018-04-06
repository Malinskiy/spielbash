module Spielbash
  class NewEnvironmentAction < Spielbash::BaseAction
    attr_accessor :command, :wait_check_cmd

    def initialize(command, wait_check_cmd, root_context)
      super(root_context)
      @command = command
      @wait_check_cmd = wait_check_cmd
    end

    def execute(session)
      command.each_char do |c|
        session.send_key(c)
        sleep(action_context.typing_delay_s)
      end
      session.send_key('C-m')

      sleep(action_context.reading_delay_s)

      action_context.wait_check_cmd = wait_check_cmd
    end
  end
end