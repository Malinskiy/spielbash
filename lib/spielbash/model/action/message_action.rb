module Spielbash
  class MessageAction < Spielbash::BaseAction
    attr_accessor :message

    def initialize(message, action_context)
      super(action_context)
      @message = message
    end

    def execute(session)
      message.each_char do |c|
        session.send_key(c)
        sleep(action_context.typing_delay_s)
      end
      sleep(action_context.reading_delay_s)

      session.send_key('C-h', message.length) if (action_context.delete)
    end
  end
end