require 'yaml'
require 'library'

class DataController
  attr_reader :databases, :library

  def initialize(data_dir: Zoomcli::DATA_DIRECTORY)
    @databases = database_names_from_directory(data_dir)
    @library = Library.new(databases, data_dir)
  end
  #Skeleton code to be implemented for next task
  #
  #
  #def list(platform = nil)
  #  list = library.fetch_games
  #end
  #
  #def fetch_platforms
  #  "platforms here"
  #end
  #
  #def new_item(input)
  #  library.add_item(input)
  #
  #end

  private

  def database_names_from_directory(dir)
    Dir["#{dir}/*.yml"].map { |f| File.basename(f, 's.yml') }
  end
end
