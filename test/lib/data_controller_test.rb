require 'minitest/autorun'
require_relative '../test_helper'

class Test < BaseModel; end

class DataControllerTest < MiniTest::Test

  def setup
    write_test_files
    @data_controller = DataController.new(data_dir: TEST_DATA_DIR)
  end

  def test_database_present
    assert_includes @data_controller.databases, 'test'
  end

  def test_library_creates_with_tests_variable
    assert @data_controller.library.respond_to?(:tests)
  end
end
