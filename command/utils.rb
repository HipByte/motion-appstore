# -*- coding: utf-8 -*-
module Utils
  ALTOOL = "/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Support/altool"

  def altool(arg)
    message = `\"#{ALTOOL}\" #{arg} 2>&1`
    messages = parse_nslog_message(message)
    print_messages(messages, $?.exitstatus == 0)

    $?.exitstatus
  end

  def archive_path
    unless File.exist?('Rakefile')
      help! "Run on Root Directoy of RubyMotion Project"
    end

    # There might be *.ipa or *.pkg in Development and Release directory.
    # In here, it takes *.ipa or *.pkg in Release with #last method
    archive = Dir.glob("./build/*/*.{ipa,pkg}").last
    unless archive
      help! "Can't find *.ipa or *.pkg. First, need to create archive file with `rake archive' or `rake archive:distribution'"
    end
    archive
  end

  def password
    # retrive password from keychain which might be created by Xcode
    `security find-internet-password -g -a #{@adc_id} -s idmsa.apple.com -r htps 2>&1`.each_line { |line|
      if line =~ /^password: "(.+)"$/
        return $1
      end
    }

    # retrive password by user input
    begin
      require 'io/console'
    rescue LoadError
    end

    prompt = bold("Enter your password: ")
    if STDIN.respond_to?(:noecho)
      print prompt
      STDIN.noecho(&:gets).strip
    else
      `read -s -p "#{prompt}" password; echo $password`.strip
    end
  end

  def parse_nslog_message(message)
    messages = []
    message.split("\n").each do |msg|
      msg.strip!
      if m = msg.match(/(No errors.+)/)
        # success
        messages << m[1]
      elsif m = msg.match(/^"Error Domain=[^"]+"(.+)\\" UserInfo=.+/)
        # error
        messages << m[1]
      end
    end
    messages
  end

  def print_messages(messages, is_success)
    mark = is_success ? green("✓ ") : red("✗ ")
    messages.each do |msg|
      puts mark + msg
    end
  end

  def bold(msg)
    ansi_output? ? "\e[1;34m" + msg + "\e[0m" : msg
  end

  def red(msg)
    ansi_output? ? "\e[1;31m" + msg + "\e[0m" : msg
  end

  def green(msg)
    ansi_output? ? "\e[1;32m" + msg + "\e[0m" : msg
  end

end
