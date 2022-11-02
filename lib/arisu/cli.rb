# frozen_string_literal: true

require 'arisu'
require 'dotenv/cli'

module Arisu
  class CLI < Dotenv::CLI
    def run
      if @overload
        Arisu.overload!(*@filenames)
      else
        Arisu.load!(*@filenames)
      end
    rescue Errno::ENOENT => e
      abort e.message
    else
      exec(*@argv) unless @argv.empty?
    end
  end
end
