# -*- encoding: utf-8 -*-
VERSION = "1.0"

Gem::Specification.new do |spec|
  spec.name          = "motion-validate"
  spec.version       = VERSION
  spec.authors       = ["Watson"]
  spec.email         = ["watson1978@gmail.com"]
  spec.description   = %q{This is RubyMotion plugin which provides validation command.}
  spec.summary       = %q{This is RubyMotion plugin which provides validation command.}
  spec.homepage      = "https://github.com/Watson1978/motion-validate"
  spec.license       = "MIT"
  spec.extensions    = ['ext/extconf.rb'] # Command-Line Plugin Installer

  files = []
  files << 'README.md'
  files.concat(Dir.glob('ext/**/*'))
  files.concat(Dir.glob('command/**/*.rb'))
  spec.files         = files
  spec.require_paths = ["lib"]
end
