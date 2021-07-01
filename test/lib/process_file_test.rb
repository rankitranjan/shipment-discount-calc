# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/process_file'

class ProcessFileTest < Minitest::Test
  include ProcessFile

  INPUT_FILE_PATH = './shipping_charges_data_set.txt'
  PATTERN = /^([A-Z]+) ([A-Z]+) (\d+(\.\d{1,2})?){1}$/.freeze

  def test_read_file
    assert read_file
    assert read_file.path
    assert_equal read_file.class, File
  end

  def test_extract_values
    assert_equal extract_values(read_file_test).class, Array
  end

  def test_valid
    assert valid?(read_file_test)
  end

  def read_file_test
    read_file.map(&:chomp)[0]
  end
end
