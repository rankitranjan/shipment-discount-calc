# frozen_string_literal: true

require_relative './shipping_rate'
require_relative './price_calculator'
require_relative '../lib/rule_sets'
require_relative '../lib/output'

# This module is responsible to provide discounted shipping charges and
# outputs the each transaction to STDOUT
module Price
  class Discount
    include RuleSets
    include Price::ShippingRate
    include Price::PriceCalculator
    include Output

    INPUT_PATTERN = /^(^\d{4}-\d{2}-\d{2}) ([A-Z]+) ([A-Z]+)$/

    attr_reader :input, :transaction_tracker

    def initialize(line, transaction_tracker)
      @input = line
      @transaction_tracker = transaction_tracker
    end

    def self.process_discount(line, transaction_tracker)
      new(line, transaction_tracker).run
    end

    def run
      if valid?
        discount_price = apply_rules_and_get_discount_price
        price = calculate_price(discount_price.to_f)
        display(dispaly_output(input, price))
        [price, extract_values]
      else
        display(dispaly_error_output(input, 'Ignored'))
      end
    end

    def extract_values
      input.match(INPUT_PATTERN).captures
    end

    def valid?
      input =~ INPUT_PATTERN
    end

    def apply_rules_and_get_discount_price
      _, size, provider = extract_values
      shipping_price = shipping_rate(provider, size)
      lowest_shipping_price = lowest_shipping_rate

      if size == 'S'
        small(shipping_price, lowest_shipping_price)
      elsif size == 'L' && provider == 'LP'
        large_lp(shipping_price, extract_values, transaction_tracker)
      else
        0.0
      end
    end
  end
end
