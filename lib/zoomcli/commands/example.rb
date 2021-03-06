# frozen_string_literal: true
require 'zoomcli'

module Zoomcli
  module Commands
    class Example < Zoomcli::Command
      def call(_args, _name)
        puts 'neato'

        if rand < 0.05
          raise(CLI::Kit::Abort, "you got unlucky!")
        end
      end

      def self.help
        "A dummy command.\nUsage: {{command:#{Zoomcli::TOOL_NAME} example}}"
      end
    end
  end
end
