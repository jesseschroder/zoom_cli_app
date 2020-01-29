require 'minitest/autorun'
require_relative '../../test_helper'

class VideoGameTest < MiniTest::Test
  TEST_CASE = {
    title: 'Super Smash Bros',
    platform: Platform.new('name' => 'Nintendo 64'),
    release: Time.at(916876800),
  }

  def setup
    @valid_model = VideoGame.new(TEST_CASE)
  end

  def test_create_properly
    assert_instance_of VideoGame, @valid_model
  end
end
