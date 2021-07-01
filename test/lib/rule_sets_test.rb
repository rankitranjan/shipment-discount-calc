# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/rule_sets'
require_relative '../../price/shipping_rate'

class RuleSetTest < Minitest::Test
  include RuleSets
  include ProcessFile
  include Price::ShippingRate

  PATTERN = /^(^\d{4}-\d{2}-\d{2}) ([A-Z]+) ([A-Z]+)$/.freeze

  def test_small
    assert small(10, 5)
    assert_equal small(10, 5), 5
  end

  def test_get_month
    date = '2015-02-01'
    assert get_month(date)
    assert_equal get_month(date), 2
  end

  def tracker_data
    @tracker_data ||= []
  end

  def test_large_lp
    tracker_data

    service_large_lp = call_service('2015-02-01 S MR')
    refute service_large_lp

    service_large_lp = call_service('2015-02-03 L LP')
    refute service_large_lp

    service_large_lp = call_service('2015-02-03 L LP')
    refute service_large_lp

    service_large_lp = call_service('2015-02-03 L LP')
    assert service_large_lp
    assert_equal service_large_lp, 6.90
  end

  def update_tracker_data(prices, input)
    @tracker_data.push(Transaction.new.send(:update_tracker, prices, input))
  end

  def call_service(line)
    pd = Price::Discount.new(line, @tracker_data.flatten)
    prices, input = pd.run
    update_tracker_data(prices, input)
    _date, size, provider = extract_values(pd.input)
    shipping_price = shipping_rate(provider, size)
    pd.large_lp(shipping_price, extract_values(pd.input), pd.transaction_tracker.flatten)
  end
end
