module Motion; class Command
  class Validate < Command

    self.summary = 'Validate an archived app'
    self.arguments = 'APPLE-ID'

    def initialize(argv)
      @adc_id = argv.shift_argument
      super
    end

    def validate!
      super
      help! "Specify an Apple ID in Apple developer center." unless @adc_id
    end

    def run
      unless File.exist?('Rakefile')
        help! "Run on Root Directoy of RubyMotion Project"
      end

      # There might be *.ipa in Development and Release directory.
      # In here, it takes *.ipa in Release with #last method
      archive = Dir.glob("./build/*/*.ipa").last
      puts bold("Validate: ") + archive
      unless archive
        help! "Can't find *.ipa. First, need to create *.ipa with `rake archive' or `rake archive:distribution'"
      end

      altool = "/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Support/altool"
      system "\"#{altool}\" -v -f #{archive} -u #{@adc_id} -p #{password}"
      exit $?.exitstatus
    end

    private

    def bold(msg)
      ansi_output? ? "\e[1;32m" + msg + "\e[0m" : msg
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

  end
end; end
