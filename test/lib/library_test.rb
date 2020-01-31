require 'minitest/autorun'
require_relative '../test_helper'

class LibraryTest < MiniTest::Test
  TEST_GAME = {
    'title' => 'A Test Game',
    'release_date' => 744336000,
    'platform_id' => 4,
  }

  REMOVE_GAME = {
    'title' => 'REMOVE ME',
  }

  TEST_PLATFORM = {
    'name' => 'Test Platform',
    'id' => -1,
  }

  REMOVE_PLATFORM = {
    'name' => 'REMOVE ME',
    'id' => 9002
  }

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

  def test_video_games_assigned_platform
    game = @library.video_games.find { |g| g.title == 'Super Mario Bros. 3'}

    assert_instance_of Platform, game.platform.find { |p| p.instance_of?(Platform)}
    assert_equal game.platform.first.id, 18
  end

  def test_add_new_game
    assert @library.add_game(TEST_GAME)
    assert @library.video_games.any? { |v| v.title == 'A Test Game'}
  end

  def test_remove_game
    @library.add_game(REMOVE_GAME)

    assert @library.remove_game('REMOVE ME')
    refute @library.video_games.any? { |g| g.title == 'REMOVE ME'}
  end

  def test_remove_bad_title
    refute @library.remove_game('NOT A REAL GAME')
  end

  def test_find_game_returns_object_array
    assert @library.find_game('Secret of Mana').any? { |g| g.instance_of?(VideoGame) }
  end

  def test_find_game_returns_correct_game
    game_arr = @library.find_game('Secret of Mana')
    assert game_arr.each { |g| g.title == 'Secret of Mana' }
  end

  def test_all_games
    game_arr = @library.all :video_games
    assert_equal game_arr.size, @library.video_games.size
  end

  def test_all_platforms
    platform = @library.platform_by_id(4)
    game_arr = @library.by_platform(platform)

    assert game_arr.any? { |g| g.title == "The Legend of Zelda: Majora's Mask"}
  end

  def test_find_platform
    assert_equal @library.platform_by_id(4).name, 'Nintendo 64'
  end

  def test_add_new_platform
    assert @library.add_platform(TEST_PLATFORM)
    assert @library.platforms.any? { |p| p.name == 'Test Platform'}
  end

  def test_remove_platform
    @library.add_platform(REMOVE_PLATFORM)

    assert @library.remove_platform(9002)
    refute @library.platforms.any? { |p| p.name == 'REMOVE ME'}
  end

  def test_remove_non_existant_platform
    refute @library.remove_platform(1239204923840294803)
  end

  def test_cant_add_platform_with_same_id
    @library.add_platform({'name' => 'super not fun platform', 'id' => 3333})
    refute @library.add_platform({'name' => 'super not fun platform', 'id' => 3333})
  end
end
