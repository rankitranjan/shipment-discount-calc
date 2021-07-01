# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../price/price_calculator'

module Price
  class PriceCalculatorTest < Minitest::Test
    include PriceCalculator

    def subject
      Price::PriceCalculator
    end

    def test_calculate_price
      discount = Price::Discount.new('2015-02-01 S MR', [])
      discount_price = discount.apply_rules_and_get_discount_price
      reduced_price, discount = discount.calculate_price(discount_price)

      assert_equal reduced_price, 1.5
      assert_equal discount, 0.5
    end

    def test_final_discount_price
      discount = Price::Discount.new('2015-02-01 S MR', [])
      expected_discount_price = discount.apply_rules_and_get_discount_price
      final_discount = final_discount_price(expected_discount_price, discount.total_discount_given_in_month)
      
      assert_equal final_discount, expected_discount_price
    end

    def test_total_discount_given_in_month
      discount = Price::Discount.new('2015-02-01 S MR', [])

      assert_equal discount.total_discount_given_in_month, 0
    end
  end
end