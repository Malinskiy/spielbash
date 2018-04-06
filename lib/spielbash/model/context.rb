module Spielbash
  class Context
    attr_accessor :typing_delay_s, :reading_delay_s, :wait, :width, :height

    def initialize(typinig_delay_s, reading_delay_s, wait, width, height)
      @typing_delay_s = typinig_delay_s
      @reading_delay_s = reading_delay_s
      @wait = wait
      @width = width
      @height = height
    end
  end
end