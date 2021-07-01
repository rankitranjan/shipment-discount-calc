# frozen_string_literal: true

require_relative '../shipment/shipping_charges'

module Price
  module ShippingRate
    def shipping_rate(provider, size)
      Shipment::ShippingCharges.all.select { |record| record.provider == provider && record.size == size }.last&.price
    end

    def lowest_shipping_rate
      Shipment::ShippingCharges.all.select { |record| record.size == 'S' }.min_by(&:price).price
    end
  end
end
