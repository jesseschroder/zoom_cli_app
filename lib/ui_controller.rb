# frozen_string_literal: true
require 'time'

module Zoomcli
  class UIController
    class InvalidInput < StandardError; end
    class InvalidDate < StandardError; end

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
          handler.option('Remove game') { puts CLI::UI.fmt(remove_game) }
          handler.option('Search games') { puts search_game }
          handler.option('Find new game') { puts CLI::UI.fmt("{{blue:Feature coming soon!}}") }
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
        CLI::UI::Prompt.ask('Choose a platform') do |handler|
          platforms.each do |platform|
            handler.option(platform[:name]) { platform[:id] }
          end
        end
      end
    end

    def new_game
      CLI::UI::Frame.open('Choose an option') do
        name = ask_and_rescue { title }
        date = ask_and_rescue { date }
        platform = ask_platform

        @data_interface.add_game(name, date, platform)
      end
    end

    def remove_game
      CLI::UI::Frame.open('Choose an option') do
        @data_interface.remove_game(title)
      end
    end

    def search_game
      CLI::UI::Frame.open('Choose an option') do
        @data_interface.find_game(title)
      end
    end

    def title
      input = CLI::UI.ask('Enter a title for the game')
      raise InvalidInput if input.empty? || input == ' '

      input
    end

    def date
      input = CLI::UI.ask('Enter a release date for the game (use YYYY-MM-DD)')
      date = Time.parse(input)
      raise InvalidDate if date.nil? || date.to_i < 0

      date.to_i
    end

    def end_session
      @active = false
    end

    def ask_and_rescue
      yield
    rescue InvalidInput
      puts CLI::UI.fmt('{{red:INVALID INPUT!!! Try again}}')
      ask_and_rescue { title }
    rescue InvalidDate && ArgumentError
      puts CLI::UI.fmt('{{red::INVALID DATE!!! Try again}}')
      ask_and_rescue { date }
    end
  end
end
