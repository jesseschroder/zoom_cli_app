# frozen_string_literal: true
require 'zoomcli'

module Zoomcli
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(
      default: 'help',
      contextual_resolver: nil
    )

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :Example, 'example', 'zoomcli/commands/example'
    register :Help,    'help',    'zoomcli/commands/help'
    register :Samples, 'samples', 'zoomcli/commands/samples'
    register :Run, 'run', 'zoomcli/commands/run'
  end
end
