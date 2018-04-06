module Spielbash
  class ActionContext < Spielbash::Context
    attr_accessor :base_context

    def initialize(base_context, typing_delay_s, reading_delay_s, wait, width, height)
      super(typing_delay_s, reading_delay_s, wait, width, height)
      @base_context = base_context
    end

    def typing_delay_s
      return @typing_delay_s.nil? ? base_context.typing_delay_s : @typing_delay_s
    end

    def reading_delay_s
      return @reading_delay_s.nil? ? base_context.reading_delay_s : @reading_delay_s
    end

    def wait
      return @wait.nil? ? base_context.wait : @wait
    end
  end
end