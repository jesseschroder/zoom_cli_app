require 'minitest/autorun'
require_relative '../test_helper'

class LibraryTest < MiniTest::Test
  def setup
    @library = Library.new(%w{video_game platform}, 'test/fixtures/')
  end


  def test_creates_instances_from_db
    @library.platforms.each { |p| assert_instance_of Platform, p}
    @library.video_games.each { |v| assert_instance_of VideoGame, v}
  end

  def test_creates_objects_with_data_from_db
    assert @library.platforms.any? { |p| p.name == 'Nintendo Entertainment System' }
    assert @library.video_games.any? { |v| v.title == 'Super Mario Bros. 3' }
  end
end
