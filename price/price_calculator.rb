# frozen_string_literal: true

module Price
  module PriceCalculator
    TOTAL_DISCOUNT_LIMIT = 10
    DEFAULT_DISCOUNT = 0.0

    def calculate_price(discount_price) # Calculates and validate the discount to be given
      _, size, provider = extract_values
      shipping_price = shipping_rate(provider, size)
      total = total_discount_given_in_month

      if total >= TOTAL_DISCOUNT_LIMIT
        [shipping_price, DEFAULT_DISCOUNT]
      elsif total <= TOTAL_DISCOUNT_LIMIT
        final_discount = final_discount_price(discount_price, total)
        reduced_price = reduced_shipment_price(shipping_price, final_discount)
        [reduced_price, final_discount]
      end
    end

    def final_discount_price(discount_price, total) # Calculates final discount
      return DEFAULT_DISCOUNT if TOTAL_DISCOUNT_LIMIT == total

      remaining_limit = (TOTAL_DISCOUNT_LIMIT - total).round(2)
      if remaining_limit <= discount_price
        remaining_limit.abs.round(2)
      else
        # remaining_limit >= discount_price
        discount_price
      end
    end

    def total_discount_given_in_month
      month = Date.parse(extract_values[0]).month # gives month number like 2 for feb and 3 for march etc
      month_group = transaction_tracker.group_by { |h| h.date.month } # grouping record by month number
      month_group[month]&.map(&:shipment_discount)&.inject(0, &:+).to_f # sum of total discount given so far.
    end

    def reduced_shipment_price(shipping_price, final_discount)
      (shipping_price - final_discount).abs.round(2)
    end
  end
end
