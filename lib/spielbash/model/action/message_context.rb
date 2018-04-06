module Spielbash
  class MessageContext < Spielbash::ActionContext
    attr_accessor :delete

    def initialize(base_context, typing_delay_s, reading_delay_s, wait, width, height, delete)
      super(base_context, typing_delay_s, reading_delay_s, wait, width, height)
      @delete = delete
    end
  end
end