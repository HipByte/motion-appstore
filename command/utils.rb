# -*- coding: utf-8 -*-

# Copyright (c) 2015, HipByte SPRL and Contributors
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

module Utils
  ALTOOL = "/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Support/altool"

  def altool(arg)
    if verbose?
      puts "----------------------------------------"
      puts " COMMAND :                              "
      puts "\"#{ALTOOL}\" #{arg}"
    end
    message = `\"#{ALTOOL}\" #{arg} 2>&1`
    if verbose?
      puts "----------------------------------------"
      puts " RETURN :                               "
      puts message
    end

    messages = parse_nslog_message(message)
    print_messages(messages, $?.exitstatus == 0)

    $?.exitstatus
  end

  def config
    unless File.exist?('Rakefile')
      help! "Run on root directoy of RubyMotion project."
    end

    unless @config
      config = `rake config`.strip
      if config.empty?
        # for motion-game/flow
        config = `rake ios:config`.strip
      end

      @config = {}
      config.lines.each do |line|
        m = line.strip.match(/(.+)\s+: (.+)/)
        if $1&&$2
        k = $1
        v = eval($2)
        @config[k.strip] = v
        end
      end
    end
    @config
  end

  def build_dir
    config['build_dir']
  end

  def deployment_target
    config['deployment_target']
  end

  def archive_path
    # select *.ipa or *.pkg in Release directory.
    target = deployment_target || "*"
    archive = Dir.glob("./#{build_dir}/{iPhoneOS,MacOSX,AppleTVOS}-#{target}-Release/*.{ipa,pkg}").first
    unless archive
      help! "Can't find *.ipa or *.pkg. First, need to create archive file with `rake archive:distribution'."
    end
    archive
  end

  def password
    # retrive password from keychain which might be created by Xcode
    if verbose?
      puts "----------------------------------------"
      puts " PASSWORD :                             "
    end
    `security find-internet-password -g -a \"#{@adc_id}\" -s idmsa.apple.com -r htps 2>&1`.each_line { |line|
      puts line if verbose?
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
      pass = STDIN.noecho(&:gets).strip
    else
      pass = `read -s -p "#{prompt}" password; echo $password`.strip
    end
    puts ""
    puts pass if verbose?
    pass
  end

  def parse_nslog_message(message)
    messages = []
    tmp = message.split("\n")
    tmp.shift if tmp[0].end_with?("Error: (")
    tmp.each do |msg|
      msg.strip!
      if m = msg.match(/(No errors.+)/)
        # success
        messages << m[1]
      elsif m = msg.match(/NSLocalizedDescription=(.+), NSLocalizedFailureReason=/)
        # error
        messages << m[1]
      elsif m = msg.match(/(Error:.+)/)
        # other errors
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
