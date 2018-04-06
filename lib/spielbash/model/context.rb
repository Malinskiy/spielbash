module Spielbash
  class Context
    attr_accessor :typing_delay_s, :reading_delay_s, :wait, :width, :height, :wait_check_cmd

    def initialize(typinig_delay_s, reading_delay_s, wait, width, height, wait_check_cmd = nil)
      @typing_delay_s = typinig_delay_s
      @reading_delay_s = reading_delay_s
      @wait = wait
      @width = width
      @height = height
      @wait_check_cmd = wait_check_cmd
    end
  end
end