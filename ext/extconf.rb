# Command-Line Plugin Installer
require 'fileutils'

dir = File.expand_path("~/Library/RubyMotion/command/")

files = ["motion-validate.rb", "motion-upload.rb"]
files.each do |file|
  src = File.expand_path(File.join(File.dirname(__FILE__), "../command/#{file}"))
  dst = File.join(dir, file)

  FileUtils.mkdir_p(dir) unless File.exist?(dir)
  FileUtils.ln_sf src, dst
end

### dummy ###
require 'mkmf'
create_makefile('')
