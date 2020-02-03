# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../test_helper'

class Test < BaseModel; end

class DataControllerTest < MiniTest::Test
  TEST_GAME = {
    'title' => 'A Test Game',
    'release_date' => 744336000,
    'platform_id' => 4,
  }

  def setup
    write_test_files
    @data_controller = DataController.new(data_dir: TEST_DATA_DIR)
  end

  def test_database_present
    assert_includes(@data_controller.databases, 'test')
  end

  def test_library_creates_with_tests_variable
    assert(@data_controller.library.respond_to?(:tests))
  end

  def test_all_games_list
    games = @data_controller.all_games
    assert_match('Top Gear 2', games)
    assert_match('August 02, 1993', games)
    assert_match('Super Nintendo Entertainment System', games)
  end

  def test_all_platforms_list
    platforms = @data_controller.all_platforms
    assert(platforms.any? { |p| p[:name] == 'Super Nintendo Entertainment System' })
    assert(platforms.any? { |p| p[:id] == 19 })
  end

  def test_games_by_platform
    response = @data_controller.games_by_platform(19)
    assert_match('Top Gear 2', response)
    assert_match('Secret of Mana', response)
  end

  def test_add_game
    assert(@data_controller.add_game(TEST_GAME['title'], TEST_GAME['release_date'], TEST_GAME['platform_id']))
    assert(@data_controller.library.video_games.any? { |v| v.title == 'A Test Game' })
  end

  def test_remove_game
    @data_controller.add_game(TEST_GAME['title'], TEST_GAME['release_date'], TEST_GAME['platform_id'])
    assert_match('Game removed!', @data_controller.remove_game('A Test Game'))
  end

  def test_remove_game_bad_title
    assert_match('Game not found!', @data_controller.remove_game('Not a real game'))
  end

  def test_find_game
    response = @data_controller.find_game('Secret of Mana')
    assert_match('Secret of Mana', response)
    assert_match('August 05, 1993', response)
  end

  def test_find_no_game
    response = @data_controller.find_game('Hello kitty island adventure')
    assert_equal(response, "\n")
  end
end
