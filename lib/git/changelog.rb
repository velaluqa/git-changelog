require 'git/changelog/log'

module Git
  module Changelog
    def self.print
      log = Log.new
      log.print_changelog
    end
  end
end
