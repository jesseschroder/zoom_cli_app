# frozen_string_literal: true
require 'zoomcli'

module Zoomcli
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Zoomcli::Resolver.call(args)
      Zoomcli::Executor.call(cmd, command_name, args)
    end
  end
end
