# -*- coding: utf-8 -*-
require_relative 'utils'

module Motion; class Command
  class Upload < Command
    include Utils

    self.summary = 'Upload an archived app to iTunes Connect.'
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
      archive = archive_path()
      puts bold("Upload: ") + archive

      exitcode = altool("--upload-app -f \"#{archive}\" -u \"#{@adc_id}\" -p \"#{password}\"")
      exit(exitcode)
    end

  end
end; end
