# frozen_string_literal: true

require_relative './shipment/transaction_tracker'
require_relative './price/discount'

# This is entry point of application where it opens the files
# read line by line and call other services to get the reduced and discounted
# rate and at the same time it alos hold transaction data.
class Transaction
  attr_reader :transaction_tracker

  def self.start(file)
    new.process_input_file(file)
  end

  def initialize
    @transaction_tracker = []
  end

  def process_input_file(file)
    file.each do |line|
      prices, line_values = Price::Discount.process_discount(line.chomp, @transaction_tracker)
      update_tracker(prices, line_values)
    end
  end

  private

  def update_tracker(prices, line_values)
    return if prices.nil? || line_values.nil?

    date, size, provider = line_values
    reduced_shipment_price, shipment_discount = prices
    options = {
      date: Date.parse(date), size: size,
      provider: provider, reduced_shipment_price: reduced_shipment_price,
      shipment_discount: shipment_discount.to_f
    }
    @transaction_tracker.push(Shipment::TransactionTrackerData.new(options))
  end
end
