# frozen_string_literal: true
require 'zoomcli'

module Zoomcli
  module Commands
    class Help < Zoomcli::Command
      def call(_args, _name)
        puts CLI::UI.fmt("{{bold:Available commands}}")
        puts ""

        Zoomcli::Commands::Registry.resolved_commands.each do |name, klass|
          next if name == 'help'
          puts CLI::UI.fmt("{{command:#{Zoomcli::TOOL_NAME} #{name}}}")
          if (help = klass.help)
            puts CLI::UI.fmt(help)
          end
          puts ""
        end
      end
    end
  end
end
