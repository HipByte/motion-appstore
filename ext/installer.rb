# Command-Line Plugin Installer
require 'fileutils'

def install_plugins
  dir = File.expand_path("~/Library/RubyMotion/command/")

  Dir.glob(File.join(File.dirname(__FILE__), "../command/motion-*")).each do |path|
    file = File.basename(path)
    src = File.expand_path(path)
    dst = File.join(dir, file)

    FileUtils.mkdir_p(dir) unless File.exist?(dir)
    FileUtils.ln_sf src, dst
  end

  # http://stackoverflow.com/questions/28461768/xcode-organizer-trying-to-access-transporter-at-wrong-directory-pathhttp://stackoverflow.com/questions/28461768/xcode-organizer-trying-to-access-transporter-at-wrong-directory-path
  itms_src = '/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/itms'
  itms_dst = '/usr/local/itms'
  if File.exist?(itms_src) && !File.exist?(itms_dst)
	FileUtils.ln_sf itms_src, itms_dst
  end
end
