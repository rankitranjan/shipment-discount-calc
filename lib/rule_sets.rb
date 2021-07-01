# frozen_string_literal: true

require 'date'

# This module keeps the rule sets of the discount to be give
# on certain condition or event.
module RuleSets
  # All S shipments should always match the lowest S package price among the providers.
  def small(shipping_price, lowest_shipping_price)
    shipping_price - lowest_shipping_price
  end

  # Third L shipment via LP should be free, but only once a calendar month.
  def large_lp(shipping_price, values, transaction_tracker)
    date, _size, _provider = values
    records = transaction_tracker.select do |data|
      data.provider == 'LP' && data.size == 'L' && data.date.month == get_month(date)
    end
    shipping_price if records.count == 2
  end

  # Other rules will go here

  private

  def get_month(date)
    Date.parse(date).month
  end
end
