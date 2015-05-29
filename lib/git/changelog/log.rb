require 'shellwords'

module Git
  module Changelog
    class Log
      def print_changelog

        puts "# Changelog\n\n"

        tags = `git tag -l`.split("\n")
        tags.map! do |v|
          begin
            Gem::Version.new(v)
          rescue
            # the tag might not be of correct version format
            # in those cases we simply ignore the tag (remove them by compact!)
            nil
          end
        end
        tags.compact!
        tags.sort!

        unless tags.empty?

          i = tags.length - 1
          while i >= 0 do
            puts "## #{tags[i]}\n\n"
            if i > 0
              start_predecessor = `git log --format=%H -n 1 #{Shellwords.escape(tags[i-1])}^2^@`.strip
              range = Shellwords.escape "#{start_predecessor}..#{tags[i]}^2"
            else
              range = Shellwords.escape "#{tags[i]}^2"
            end
            print_commits(`git log --graph --oneline #{range}`)
            i -= 1
          end

        else

          print_commits(`git log --graph --oneline develop`)

        end
      end

      private

      def print_commits(log_output)
        log_lines = log_output.split("\n")
        log_lines.pop
        log_lines.map! do |log_line|
          log_line =~ /([^a-f0-9]*[a-f0-9]+ )/
          unless $1.nil?
            "`#{log_line[0..$1.length-1]}` #{log_line[$1.length..-1]}"
          else
            "`#{log_line}`"
          end
        end
        log_lines.compact!
        puts log_lines.join("<br/>\n")
        puts "\n"
      end
    end
  end
end
