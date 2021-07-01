# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/rule_sets'
require_relative '../../price/shipping_rate'

class RuleSetTest < Minitest::Test
  include RuleSets
  include ProcessFile
  include Price::ShippingRate
  
  PATTERN = /^(^\d{4}-\d{2}-\d{2}) ([A-Z]+) ([A-Z]+)$/

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
    service = call_service("2015-02-01 S MR")
    date, size, provider = extract_values(service.input)
    shipping_price = shipping_rate(provider, size)
    large_lp_free = service.large_lp(shipping_price, extract_values(service.input), service.transaction_tracker.flatten)

    refute large_lp_free

    service = call_service("2015-02-03 L LP")
    date, size, provider = extract_values(service.input)
    shipping_price = shipping_rate(provider, size)
    large_lp_free = service.large_lp(shipping_price, extract_values(service.input), service.transaction_tracker.flatten)

    refute large_lp_free

    service = call_service("2015-02-03 L LP")
    date, size, provider = extract_values(service.input)
    shipping_price = shipping_rate(provider, size)
    large_lp_free = service.large_lp(shipping_price, extract_values(service.input), service.transaction_tracker.flatten)

    refute large_lp_free

    service = call_service("2015-02-03 L LP")
    date, size, provider = extract_values(service.input)
    shipping_price = shipping_rate(provider, size)
    large_lp_free = service.large_lp(shipping_price, extract_values(service.input), service.transaction_tracker.flatten)

    assert large_lp_free
    assert_equal large_lp_free, 6.90
  end

  def update_tracker_data(prices, input)
    @tracker_data.push(Transaction.new.update_tracker(prices, input))
  end

  def call_service(line)
    pd = Price::Discount.new(line, @tracker_data.flatten)
    prices, input = pd.run
    update_tracker_data(prices, input)
    pd
  end
end
