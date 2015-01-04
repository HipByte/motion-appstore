# -*- encoding: utf-8 -*-
VERSION = "1.0.2"

Gem::Specification.new do |spec|
  spec.name          = "motion-validate"
  spec.version       = VERSION
  spec.authors       = ["Watson"]
  spec.email         = ["watson1978@gmail.com"]
  spec.description   = %q{This is RubyMotion plugin which provides commands deal with iTunes Connect.}
  spec.summary       = %q{This is RubyMotion plugin which provides commands deal with iTunes Connect.}
  spec.homepage      = "https://github.com/Watson1978/motion-appstore"
  spec.license       = "MIT"
  spec.extensions    = ['ext/extconf.rb'] # Command-Line Plugin Installer

  files = []
  files << 'README.md'
  files.concat(Dir.glob('ext/**/*'))
  files.concat(Dir.glob('command/**/*.rb'))
  spec.files         = files
  spec.require_paths = ["lib"]
end
