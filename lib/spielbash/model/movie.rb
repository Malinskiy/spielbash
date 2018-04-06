module Spielbash
  class Movie
    attr_accessor :title, :pre_run_actions, :actions, :post_run_actions, :context, :output_path, :session

    def initialize(title, pre_run_actions, actions, post_run_actions, context, output_path)
      @title = title
      @pre_run_actions = pre_run_actions
      @actions = actions
      @post_run_actions = post_run_actions
      @context = context
      @output_path = output_path
    end

    def shoot
      session = Spielbash::Session.new(title.downcase.split.join('_'), output_path, context)
      session.new_session

      pre_run_actions.each do |action|
        action.execute(session)
      end

      session.start_recording

      actions.each do |action|
        action.execute(session)
      end

      session.stop_recording

      post_run_actions.each do |action|
        action.execute(session)
      end

      session.stop_recording
      session.close_session
    end

    def interrupt
      Spielbash::PressKeyAction.new('C-c', context).execute(session) unless session.nil?
    end
  end
end
