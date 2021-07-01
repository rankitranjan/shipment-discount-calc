# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../shipment/shipping_charges'

module Shipment
  class ShippingChargesTest < Minitest::Test
    def subject
      Shipment::ShippingCharges
    end

    def test_check_if_file_exists
      assert File.exist?(subject::INPUT_FILE_PATH)
    end

    def test_check_if_file_type
      assert_equal File.extname(subject::INPUT_FILE_PATH), '.txt'
    end

    def test_parse_and_set_to_data_attr
      data = subject.new

      assert_equal data.data.class, Array
      assert_equal data.data.count, 6
    end

    def test_shipping_charges_data
      data = subject.new

      data.data.each do |d|
        validate_shipping_charges_object(d)
      end
    end

    def validate_shipping_charges_object(data)
      assert data.is_a?(ShippingChargesDate)
      assert data.respond_to? :price
      assert data.respond_to? :provider
      assert data.respond_to? :size
      assert_equal data.price.class, Float
    end
  end
end
