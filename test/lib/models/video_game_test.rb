require 'minitest/autorun'
require_relative '../../test_helper'

class VideoGameTest < MiniTest::Test
  TEST_CASE = {
    title: 'Super Smash Bros',
    platform: Platform.new('name' => 'Nintendo 64'),
    release: Time.at(916876800),
    platform_id: 4,
  }

  TEST_PLATFORM = Platform.new({'title' => 'test', 'id' => -1})

  def setup
    @valid_model = VideoGame.new(TEST_CASE)
  end

  def test_create_properly
    assert_instance_of VideoGame, @valid_model
  end

  def test_assign_platform
    @valid_model.assign_platform(TEST_PLATFORM)

    assert @valid_model.respond_to?(:platform)
    assert_instance_of Platform, @valid_model.platform
  end
end
