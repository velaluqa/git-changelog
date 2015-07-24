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
              start = `git log --format=%H -n 1 #{Shellwords.escape(tags[i-1].to_s)}^2`.strip
              start_predecessor = `git log --format=%H -n 1 #{start}^@`.strip
              range = Shellwords.escape "#{start_predecessor}..#{tags[i].to_s}^2"
            else
              start = `git log --format=%H | tail -n 1`.strip
              range = Shellwords.escape "#{tags[i].to_s}^2"
            end
            print_commits(`git log --graph --oneline #{range}`, start)
            i -= 1
          end

        else

          print_commits(`git log --graph --oneline develop`, start)

        end
      end

      private

      def print_commits(log_output, start)
        log_lines = log_output.split("\n")
        reached_start = false
        output = []
        log_lines.each do |log_line|
          # some output lines are tree-only and without commit:
          # * | 40712a4  Sort curves the same way in legend and graph aside
          # |/
          if not reached_start
            /(?<tree>[^a-f0-9]*)(?:(?<short_rev>[a-f0-9]+)(?<message>.+))?$/ =~ log_line
            if short_rev.nil?
              output.push "`#{tree.strip}`"
            else
              if start =~ /^#{short_rev}/
                throw "error" if start.nil?
                reached_start = true
              else
                output.push "`#{tree}#{short_rev}`#{message}"
              end
            end
          end
        end
        puts output.join("<br/>\n")
        puts "\n"
      end
    end
  end
end
