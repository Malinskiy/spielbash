module Spielbash
  class PressKeyAction < Spielbash::BaseAction
    attr_accessor :key

    def initialize(key, action_context)
      super(action_context)
      @key = key
    end

    def execute(session)
      session.send_key(key)
    end
  end
end