require_relative 'models/base_model'
require_relative 'models/video_game'
require_relative 'models/platform'
require 'pry'

class Library
  attr_reader :data_dir

  def initialize(db, dir)
    @data_dir = dir
    db.each { |name| instance_variable_set("@#{name}s", read_and_create(name))}

    instance_variables.each { |var| self.class.public_send(:attr_reader, var.to_s.delete_prefix('@')) }
    assign_platforms
  end

  def add_game(options = {})
    game = VideoGame.new(options)
    @video_games.push(game)
    true
  end

  def remove_game(title)
    if by_title(@video_games, title).empty?
      return false
    else
      @video_games.delete_if { |g| g.title == title}
    end
    true
  end

  def find_game(title)
    by_title(@video_games, title)
  end

  def all(var)
    self.public_send(var)
  end

  def by_platform(platform)
    @video_games.select { |g| g.platform.any? platform }
  end

  def platform_by_id(id)
    @platforms.find { |p| p.id == id}
  end

  def add_platform(options = {})
    if platform_by_id(options.fetch('id', 0))
      return false
    else
      platform = Platform.new(options)
      @platforms.push(platform)
    end
    true
  end

  def remove_platform(id)
    unless platform_by_id(id)
      return false
    else
      @platforms.delete_if { |p| p.id == id }
    end
    true
  end

  private

  def by_title(collection, title)
    collection.select { |i| i.title == title}
  end

  def read_and_create(name)
    data = YAML.load_file("#{data_dir + name}s.yml")
    klass = name.split('_').map(&:capitalize).join

    data.map { |args| Class.const_get(klass).public_send(:new, args) }
  end

  def assign_platforms
    @video_games.each do |game|
      id = game.platform_id
      platform = @platforms.find { |p| p.id == id}

      game.assign_platform(platform)
    end
  end
end
