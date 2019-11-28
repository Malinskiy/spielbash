
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "spielbash/version"

Gem::Specification.new do |spec|
  spec.name          = "spielbash"
  spec.version       = Spielbash::VERSION
  spec.authors       = ["Anton Malinskiy"]
  spec.email         = ["anton@malinskiy.com"]

  spec.summary       = %q{Spielbash helps you to automate asciicasts with asciinema.}
  spec.description   = %q{Tool to automate bash movie-making with asciinema. Be the Spielberg of bash.}
  spec.homepage      = "https://github.com/Malinskiy/spielbash"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|coverage|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'gli', '~> 2.17'
  spec.add_runtime_dependency 'childprocess', '>= 0.9', '< 4.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.2'
  spec.add_development_dependency 'simplecov', '~> 0.14'
  spec.add_development_dependency 'simplecov-json', '~> 0.2'
end
