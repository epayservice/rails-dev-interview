# This file is used by Rack-based servers to start the application.

require_relative "config/environment"
require_relative "lib/payment_gateway"

map "/payment_gateway" do
  run PaymentGateway.new
end

run Rails.application
Rails.application.load_server
