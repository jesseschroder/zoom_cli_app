# frozen_string_literal: true
require 'zoomcli'
require 'data_controller'
require 'ui_controller'

module Zoomcli
  module Commands
    class Run < Zoomcli::Command
      def call(_args, _name)
        CLI::UI::StdoutRouter.enable
        CLI::UI::Frame.open('Program Running') do
          data = DataController.new
          ui = UIController.new(data)
          load_data

          puts 'Welcome! Please follow the prompts below.'
          ui.main_menu while ui.active
        end
      end

      private

      def load_data
        CLI::UI::Frame.open('Loading data from databases...') do
          CLI::UI::Progress.progress do |bar|
            100.times do
              sleep 0.025
              bar.tick
            end
          end
        end
      end

      class << self
        def help
          "I will make stuff one day."
        end
      end
    end
  end
end
