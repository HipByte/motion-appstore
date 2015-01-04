# Command-Line Plugin Installer
require 'fileutils'

def install_plugins
  dir = File.expand_path("~/Library/RubyMotion/command/")

  Dir.glob(File.join(File.dirname(__FILE__), "../command/motion-*")).each do |path|
    file = File.basename(path)
    src = File.expand_path(file)
    dst = File.join(dir, file)

    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    FileUtils.ln_sf src, dst
  end
end
