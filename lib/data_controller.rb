# frozen_string_literal: true
require 'yaml'
require 'erb'
require_relative 'library'
require 'yamlgem'

class DataController
  attr_reader :databases, :library

  def initialize(data_dir: Zoomcli::DATA_DIRECTORY)
    @databases = database_names_from_directory(data_dir)
    @library = Library.new(databases, data_dir)
    YamlGem.say_hi
  end

  def all_games
    @games = @library.all(:video_games)
    erb(:video_game_list)
  end

  def all_platforms
    @library.platforms.map do |platform|
      {
        id: platform.id,
        name: platform.name,
      }
    end
  end

  def games_by_platform(id)
    @games = @library.by_platform(@library.platform_by_id(id))
    erb(:video_game_list)
  end

  def add_game(name, date, platform)
    @library.add_game('title' => name, 'release_date' => date, 'platform_id' => platform)
  end

  def remove_game(title)
    if @library.remove_game(title)
      "{{green:Game removed!}}"
    else
      "{{red:Game not found!}}"
    end
  end

  def find_game(title)
    @games = @library.find_game(title)
    erb(:video_game_list)
  end

  private

  def database_names_from_directory(dir)
    Dir["#{dir}/*.yml"].map { |f| File.basename(f, 's.yml') }
  end

  def erb(template)
    template_file = File.read("lib/views/#{template}.html.erb")
    ERB.new(template_file).result(binding)

  rescue SystemCallError
    "No available view"
  end
end
