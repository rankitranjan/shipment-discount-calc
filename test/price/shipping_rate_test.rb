# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../price/shipping_rate'

module Price
  class ShippingRateTest < Minitest::Test
    include ShippingRate

    SIZE = 'M'
    PROVIDER = 'MR'

    def setup
      @shipping_charges = Shipment::ShippingCharges.import.data
    end

    def test_lowest_shipping_rate
      expected_lowest_shipping_rate = @shipping_charges.select { |record| record.size == 'S' }.min_by(&:price).price

      assert_equal lowest_shipping_rate, expected_lowest_shipping_rate
    end

    def test_shipping_rate
      expected_shipping_rate = @shipping_charges.select { |record| record.provider == PROVIDER && record.size == SIZE }.last&.price

      assert_equal shipping_rate(PROVIDER, SIZE), expected_shipping_rate
    end
  end
end
