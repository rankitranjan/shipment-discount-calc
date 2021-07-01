# frozen_string_literal: true

require_relative '../shipment/shipping_charges'

module Price
  # This ShippingRate module a wrapper around shipping_charges module where
  # this will help to find the Shipping Charges for a provider with size.
  module ShippingRate
    SMALLEST_SIZE = 'S'

    def shipping_rate(provider, size)
      Shipment::ShippingCharges.all.select { |record| record.provider == provider && record.size == size }.last&.price
    end

    def lowest_shipping_rate
      Shipment::ShippingCharges.all.select { |record| record.size == SMALLEST_SIZE }.min_by(&:price).price
    end
  end
end
