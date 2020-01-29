require 'minitest/autorun'
require 'pry'
require_relative '../../test_helper'

class PlatformTest < MiniTest::Test
  TEST_CASE = {
    name: 'Test Console',
  }

  def setup
    @valid_model = Platform.new(TEST_CASE)
  end

  def test_create_properly
    assert_instance_of Platform, @valid_model
  end
  def test_stuff
    assert_equal true, true
  end
end
