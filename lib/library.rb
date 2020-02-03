# frozen_string_literal: true
require_relative 'models/base_model'
require_relative 'models/video_game'
require_relative 'models/platform'
require 'pry'

class Library
  attr_reader :data_dir

  def initialize(db, dir)
    @data_dir = dir
    db.each { |name| instance_variable_set("@#{name}s", read_and_create(name)) }

    instance_variables.each { |var| self.class.public_send(:attr_reader, var.to_s.delete_prefix('@')) }
    assign_platforms

    @db_writer = YamlGem.new(dir)
  end

  def add_game(options = {})
    game = VideoGame.new(options)
    @video_games.push(game)
    game.assign_platform(platform_by_id(game.platform_id))

    @db_writer.save(options, :video_games)
    true
  end

  def remove_game(title)
    to_delete = by_title(@video_games, title)
    return false if to_delete.empty?

    delete_data = to_delete.map(&:to_hsh)
    @db_writer.remove(delete_data, :video_games)
    true if @video_games.delete_if { |g| g.title == title }
  end

  def find_game(title)
    by_title(@video_games, title)
  end

  def all(var)
    public_send(var)
  end

  def by_platform(platform)
    @video_games.select { |g| g.platform.any?(platform) }
  end

  def platform_by_id(id)
    @platforms.find { |p| p.id == id }
  end

  def add_platform(options = {})
    return false if platform_by_id(options.fetch('id', 0))

    platform = Platform.new(options)
    true if @platforms.push(platform)
  end

  def remove_platform(id)
    return false unless platform_by_id(id)
    true if @platforms.delete_if { |p| p.id == id }
  end

  private

  def by_title(collection, title)
    collection.select { |i| i.title == title }
  end

  def read_and_create(name)
    data = YAML.load_file("#{data_dir + name}s.yml")
    klass = name.split('_').map(&:capitalize).join

    data.map { |args| Class.const_get(klass).public_send(:new, args) }
  end

  def assign_platforms
    @video_games.each do |game|
      id = game.platform_id
      platform = @platforms.find { |p| p.id == id }

      game.assign_platform(platform)
    end
  end
end
