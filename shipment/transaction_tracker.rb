# frozen_string_literal: true

module Shipment
  class TransactionTrackerData
    attr_reader :date, :provider, :size, :reduced_shipment_price, :shipment_discount

    def initialize(options)
      @date = options[:date]
      @provider = options[:provider]
      @size = options[:size]
      @reduced_shipment_price = options[:reduced_shipment_price]
      @shipment_discount = options[:shipment_discount]
    end
  end
end
