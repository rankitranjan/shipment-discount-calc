# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/output'
require 'logger'

class OutputTest < Minitest::Test
  include Output

  def test_dispaly_output
    data = %w[2015-02-01 S MR]
    new_price = %w[1.50 0.50]
    expected = '2015-02-01 S MR 1.50 0.50'

    assert_equal dispaly_output(data.join(' '), new_price.map(&:to_f)), expected
  end

  def test_dispaly_error_output
    data = '2015-02-01 S MR'
    ignored = 'Ignored'
    expected = '2015-02-01 S MR Ignored'

    assert_equal dispaly_error_output(data, ignored), expected
  end
end
