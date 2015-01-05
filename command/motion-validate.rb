# -*- coding: utf-8 -*-
require_relative 'utils'

module Motion; class Command
  class Validate < Command
    include Utils

    self.summary = 'Validate an archived app.'
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
      puts bold("Validate: ") + archive

      exitcode = altool("-v -f #{archive} -u #{@adc_id} -p #{password}")
      exit(exitcode)
    end

  end
end; end
