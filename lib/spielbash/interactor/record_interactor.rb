require 'yaml'

module Spielbash
  class RecordInteractor
    def execute(script_path, output_path)
      script = YAML.load_file(script_path)
      title = script['title']
      opts = script['options']

      typing_delay_s = opts['typing_delay_s']
      reading_delay_s = opts['reading_delay_s']
      wait = opts['wait']
      width = opts['width']
      height = opts['height']
      wait_check_cmd = opts['wait_check_cmd']

      context = Spielbash::Context.new(typing_delay_s, reading_delay_s, wait, width, height, wait_check_cmd)

      actions = create_actions(context, script['scenes'])
      pre_run_actions = script['pre-run'].nil? ? [] : create_actions(context, script['pre-run'])
      post_run_actions = script['post-run'].nil? ? [] : create_actions(context, script['post-run'])

      movie = Spielbash::Movie.new(title, pre_run_actions, actions, post_run_actions, context, output_path)
      movie.shoot
    end

    private

    def create_actions(context, scenes)
      actions = []
      for scene in scenes do
        action_opts = scene['options'].nil? ? Hash.new : scene['options']
        action_context = Spielbash::ActionContext.new(context,
                                                      action_opts['typing_delay_s'],
                                                      action_opts['reading_delay_s'],
                                                      action_opts['wait'],
                                                      action_opts['width'],
                                                      action_opts['height'])

        action = case
                 when scene.has_key?('message') then
                   value = scene['message']
                   message_context = Spielbash::MessageContext.new(context,
                                                                   action_opts['typing_delay_s'],
                                                                   action_opts['reading_delay_s'],
                                                                   action_opts['wait'],
                                                                   action_opts['width'],
                                                                   action_opts['height'],
                                                                   action_opts['delete'].nil? ? true : action_opts['delete'])
                   Spielbash::MessageAction.new(value, message_context)
                 when scene.has_key?('command') then
                   value = scene['command']
                   Spielbash::CommandAction.new(value, action_context)
                 when scene.has_key?('pause') then
                   value = scene['pause']
                   Spielbash::PauseAction.new(value, action_context)
                 when scene.has_key?('key') then
                   value = scene['key']
                   Spielbash::PressKeyAction.new(value, action_context)
                 when scene.has_key?('new_env') then
                   cmd = scene['new_env']
                   wait_cmd = scene['wait_check_cmd']
                   Spielbash::NewEnvironmentAction.new(cmd, wait_cmd, context)
                 when scene.has_key?('delete_env') then
                   cmd = scene['delete_env']
                   Spielbash::DeleteEnvironmentAction.new(cmd, context)
                 else
                   not_implemented
                 end

        actions << action
      end

      actions
    end
  end
end