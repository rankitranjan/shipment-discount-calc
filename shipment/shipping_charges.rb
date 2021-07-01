# frozen_string_literal: true

require_relative '../lib/process_file'

module Shipment
  class ShippingCharges
    include ProcessFile
    INPUT_FILE_PATH = './shipping_charges_data_set.txt'
    PATTERN = /^([A-Z]+) ([A-Z]+) (\d+(\.\d{1,2})?){1}$/

    attr_reader :data

    def initialize
      @data = parse
    end

    def self.import
      new
    end

    def self.all
      import.data
    end

    def parse
      parsed_data = []
      read_file.each do |line|
        if valid?(line)
          provider, size, price = extract_values(line)
          parsed_data.push(ShippingChargesDate.new({ provider: provider, size: size, price: price.to_f }))
        end
      end
      parsed_data
    end
  end
end

class ShippingChargesDate
  attr_reader :provider, :size, :price

  def initialize(options)
    @provider = options[:provider]
    @size = options[:size]
    @price = options[:price]
  end
end
