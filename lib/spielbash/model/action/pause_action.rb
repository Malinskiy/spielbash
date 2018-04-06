module Spielbash
  class PauseAction < Spielbash::BaseAction
    attr_accessor :length

    def initialize(length, action_context)
      super(action_context)
      @length = length
    end

    def execute(_session)
      sleep(length)
    end
  end
end