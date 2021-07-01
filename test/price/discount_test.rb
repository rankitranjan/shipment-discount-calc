# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../price/discount'
require_relative '../../lib/output'

module Price
  class DiscountTest < Minitest::Test
    include Output

    def subject
      Price::Discount
    end

    def test_run
      @disount = subject.process_discount('2015-02-01 S MR', [])
      new_price, _data = @disount
      reduced_price, discount_price = new_price

      assert_equal discount_price, '0.50'
      assert_equal reduced_price, '1.50'
    end

    def test_extract_values
      discount = Price::Discount.new('2015-02-01 S MR', [])
      expected_values = %w[2015-02-01 S MR]
      extracted_values = discount.send(:extract_values)

      assert_equal extracted_values, expected_values
      assert_equal extracted_values.class, Array
      assert_equal extracted_values.count, expected_values.count
    end

    def test_valid?
      discount = Price::Discount.new('2015-02-01 S MR', [])
      assert discount.send(:valid?)

      discount = Price::Discount.new('some random text', [])
      refute discount.send(:valid?)
    end

    def test_apply_rules_get_discount_price_when_size_s_and_provider_mr
      discount = Price::Discount.new('2015-02-01 S MR', [])
      discount_price = discount.send(:apply_rules_and_get_discount_price)

      assert_equal discount_price, 0.5

      discount = Price::Discount.new('2015-02-01 S MR', [])
      discount_price = discount.send(:apply_rules_and_get_discount_price)

      assert_equal discount_price, 0.5
    end

    def test_apply_rules_get_discount_price_when_size_l_and_provider_lp
      discount = Price::Discount.new('2015-02-09 L LP', [])
      discount_price = discount.send(:apply_rules_and_get_discount_price).to_i

      assert_equal discount_price, 0
    end
  end
end
