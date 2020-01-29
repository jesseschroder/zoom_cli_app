
module Zoomcli
  class UIController
    attr_reader :data_interface, :active

    def initialize(data_interface)
      @data_interface = data_interface
      @active = true
    end

    def main_menu
      CLI::UI::Frame.open('Choose a command') do
        CLI::UI::Prompt.ask('Command') do |handler|
          handler.option('List all games')  { puts list }
          handler.option('Add game') { puts new_game }
          handler.option('Remove game')
          handler.option('Search games')
          handler.option('Find new game')
          handler.option('quit') { end_session }
        end

      end
    end

    private
    #Skeleton code to be implemented for next task
    #
    #
    #def list
    #  CLI::UI::Prompt.ask('Would you like to filter games by platform or list all games?') do |handler|
    #    handler.option('By platform') { select_platform }
    #    handler.option('All') { data_interface.list }
    #
    #  end
    #end
    #
    #def select_platform
    #  data_interface.fetch_platforms
    #end
    #
    #def new_game
    #  "ui here for new game input"
    #  data_interface.new_item("input")
    #end

    def end_session
      @active = false
    end
  end
end
