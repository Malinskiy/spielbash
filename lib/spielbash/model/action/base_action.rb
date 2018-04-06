module Spielbash
  class BaseAction
    attr_accessor :action_context

    def initialize(action_context)
      @action_context = action_context
    end
  end
end