# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../shipment/transaction_tracker'

module Shipment
  class TransactionTrackerDataTest < Minitest::Test
    def subject
      Shipment::TransactionTrackerData
    end

    def test_transaction_tracker_data
      tracker_data = subject.new(
        date: '2015-02-07', provider: 'xyz',
        size: 'S', reduced_shipment_price: 2,
        shipment_discount: 4
      )
      check_methods(tracker_data)
      assert tracker_data.is_a?(Shipment::TransactionTrackerData)
      assert_equal tracker_data.reduced_shipment_price.class, Integer
      assert_equal tracker_data.shipment_discount.class, Integer
    end

    def check_methods(tracker_data)
      %i[date provider reduced_shipment_price shipment_discount size].each do |attr_name|
        tracker_data.respond_to?(attr_name)
      end
    end
  end
end
