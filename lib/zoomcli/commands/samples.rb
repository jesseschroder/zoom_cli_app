# frozen_string_literal: true
require 'zoomcli'
require 'yaml'
require 'pry'

module Zoomcli
  module Commands
    class Samples < Zoomcli::Command
      def call(_args, _name)
        CLI::UI::StdoutRouter.enable
        CLI::UI::Frame.open('Sample Loading') do
          CLI::UI::Prompt.ask('What would you like to do?') do |handler|
            handler.option('Load samples') { load }
            handler.option('Clear DB') { cleardb }
          end
        end
      end

      def load
        db = YAML.load_file('db/video_games.yml') || []
        if db.empty?
          samples = YAML.load_file('db/example/sample.yml')
          platforms = samples.map { |item| item['platform'] }.uniq
          games = samples.map { |item| remove_value(item, 'platform') }

          File.open('db/platforms.yml', 'w') { |f| f.write(platforms.to_yaml) }
          File.open('db/video_games.yml', 'w') { |f| f.write(games.to_yaml) }
        else
          puts CLI::UI.fmt("{{red:You must clear the DB before adding sample data!}}")
        end
      end

      def cleardb
        CLI::UI::Prompt.ask('This will remove all data. Do you want to continue?') do |handler|
          handler.option('yes') { delete }
          handler.option('no') { next }
        end
      end

      private

      def delete
        File.open('db/video_games.yml', 'w') { |f| f.write('---') }
        File.open('db/platforms.yml', 'w') { |f| f.write('---') }
      end

      def remove_value(hash, key)
        hash.delete(key)
        hash
      end

      class << self
        def help
          "Adds sample data to database. Can also remove data.\nUsage: {{command:#{Zoomcli::TOOL_NAME}
 sample <arg>}}\n\nLoad = add sample data from db/example/sample.yml. \nCleardb = clears data from yamls
 to allow for samples to be laoded."
        end
      end
    end
  end
end
