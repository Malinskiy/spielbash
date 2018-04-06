# Spielbash

Spielbash helps you to automate asciicasts with asciinema.

![Sample output](sample/sample.gif?raw=true "Sample")

Requirements
------------

* asciinema > 1.0
* tmux
* resize
* pgrep

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spielbash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spielbash

## Usage

```console
$ spielbash -h
NAME
    spielbash - Tool to automate bash movie-making with asciinema. Be the Spielberg of bash

SYNOPSIS
    spielbash [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help             - Show this message
    -v, --[no-]verbose - Be verbose

COMMANDS
    help   - Shows a list of commands or help for one command
    record - Create a recording
```

```console
$ spielbash record -h
NAME
    record - Create a recording

SYNOPSIS
    spielbash [global options] record [command options] 

COMMAND OPTIONS
    -o, --output=arg - Output file (default: none)
    --script=arg     - Script file path (default: none)

```

See [scenario_1.yaml](spec/fixtures/files/scenario_1.yaml) for more detail on the script file

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Malinskiy/spielbash. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

This project is a complete rewrite of [spielbash by Red Hat Cloud Innovation Practice](https://github.com/redhat-cip/spielbash) in Ruby.

## Code of Conduct

Everyone interacting in the Spielbash project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/spielbash/blob/master/CODE_OF_CONDUCT.md).
