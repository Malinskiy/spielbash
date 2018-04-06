module Spielbash
  class DeleteEnvironmentAction < Spielbash::BaseAction
    attr_accessor :command

    def initialize(command, root_context)
      super(root_context)
      @command = command
    end

    def execute(session)
      command.each_char do |c|
        session.send_key(c)
        sleep(action_context.typing_delay_s)
      end
      session.send_key('C-m')

      sleep(action_context.reading_delay_s)

      action_context.wait_check_cmd = nil
    end
  end
end