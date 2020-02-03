# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

begin
  addpath = lambda do |p|
    path = File.expand_path("../../#{p}", __FILE__)
    $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
  end
  addpath.call("lib")
end

TEST_DATA_DIR = 'test/fixtures/'

require_relative '../lib/zoomcli'
require_relative '../lib/models/base_model'
require_relative '../lib/models/platform'
require_relative '../lib/models/video_game'
require_relative '../lib/ui_controller'
require_relative '../lib/data_controller'
require_relative '../lib/library'

require 'cli/kit'

require 'fileutils'
require 'tmpdir'
require 'tempfile'

require 'rubygems'
require 'bundler/setup'

CLI::UI::StdoutRouter.enable

require 'minitest/autorun'
require "minitest/unit"
require 'minitest/reporters'
require 'mocha/minitest'

MiniTest::Reporters.use!

def write_test_files
  test_file = File.new("#{TEST_DATA_DIR}tests.yml", 'w')
  test_file.puts [{ 'test' => 'test' }].to_yaml
  test_file.close
end
