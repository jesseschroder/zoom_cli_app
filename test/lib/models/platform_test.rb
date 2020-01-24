require 'minitest/autorun'

class PlatformTest < MiniTest::Unit::TestCase
  TEST_CASE = {
    title: 'Super Smash Bros',
    platform: Platform.new('Nintendo 64'),
    release: Time.at(916876800),
  }

  def setup
    @valid_model = VideoGame.new(TEST_CASE)
  end

  test 'mode properly creates' do
    assert_instance_of VideoGame, @valid_model
  end

  def teardown
    # Do nothing
  end

  def test
    skip 'Not implemented'
  end
end
