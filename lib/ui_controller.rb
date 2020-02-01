
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
          handler.option('Remove game') { puts CLI::UI.fmt remove_game }
          handler.option('Search games') { puts search_game }
          handler.option('Find new game') { puts CLI::UI.fmt "{{blue:Feature coming soon!}}" }
          handler.option('quit') { end_session }
        end

      end
    end

    private

    def list
      CLI::UI::Frame.open('Choose an option') do
        CLI::UI::Prompt.ask('Choose an option') do |handler|
          handler.option('All games') { @data_interface.all_games }
          handler.option('By Platform') { @data_interface.games_by_platform(ask_platform) }
        end
      end
    end

    def ask_platform
      platforms = @data_interface.all_platforms
      CLI::UI::Frame.open('Choose an option') do
        CLI::UI::Prompt.ask('Choose an platform') do |handler|
          platforms.each do |platform|
            handler.option(platform[:name]) { platform[:id] }
          end
        end
      end
    end

    def new_game
      CLI::UI::Frame.open('Choose an option') do
        name = ask_title
        date = Time.new(ask_date).to_i
        while date < 0
          date = Time.new(ask_date).to_i
        end
        platform = ask_platform
        @data_interface.add_game(name, date, platform)
      end
    end

    def remove_game
      CLI::UI::Frame.open('Choose an option') do
        @data_interface.remove_game(ask_title)
      end
    end

    def search_game
      CLI::UI::Frame.open('Choose an option') do
        @data_interface.find_game(ask_title)
      end
    end

    def ask_title
      CLI::UI.ask('Enter a title for the game', default: 'Default')
    end

    def ask_date
      CLI::UI.ask('Enter a release date for the game (use YYYY-MM-DD)')
    end

    def end_session
      @active = false
    end
  end
end
