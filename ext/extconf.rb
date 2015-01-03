# Command-Line Plugin Installer
require 'fileutils'

dir = File.expand_path("~/Library/RubyMotion/command/")
src = File.expand_path(File.join(File.dirname(__FILE__), "../command/motion-doc.rb"))
dst = File.join(dir, "motion-doc.rb")

FileUtils.mkdir_p(dir) unless File.exist?(dir)
FileUtils.rm dst if File.exist?(dst)
FileUtils.ln_s src, dst


### dummy ###
require 'mkmf'
create_makefile('')
