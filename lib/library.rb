require_relative 'models/base_model'
require_relative 'models/video_game'
require_relative 'models/platform'
require 'pry'

class Library
  attr_reader :data_dir

  def initialize(db, dir)
    @data_dir = dir
    db.each { |name| instance_variable_set("@#{name}s", read_and_create(name))}

    instance_variables.each { |var| self.class.send(:attr_reader, var.to_s.delete('@')) }
  end
  #Skeleton code to be implemented for next task
  #
  #
  #def fetch_games(platform = nil, title = nil)
  #  if platform
  #    by_platform(platform)
  #  elsif title
  #    by_title(platform)
  #  end
  #  all
  #end
  #
  #def add_item(input)
  #
  #end

  private

  def read_and_create(name)
    data = YAML.load_file("#{data_dir + name}s.yml")
    klass = name.split('_').map(&:capitalize).join

    data.map { |args| Class.const_get(klass).new(args) }
  end
end