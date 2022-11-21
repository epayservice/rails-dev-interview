require "sinatra/base"

class PaymentGatewayStore
  FILE_PATH = File.expand_path(File.join(__dir__, "../tmp/payment_gateway_store.json"))

  def get_all_payments
    data = read_file
    data.nil? ? [] : JSON.parse(data)
  end

  def add_new_payment(params)
    payments = get_all_payments
    payments.push params
    write_file payments.to_json
  end

  private

  def read_file
    File.read(FILE_PATH) if File.exists?(FILE_PATH)
  end

  def write_file(data)
    File.open(FILE_PATH, "w") { |f| f.write(data) }
  end
end

class PaymentGateway < Sinatra::Base
  set :default_content_type, :json
  set :show_exceptions, false

  def parse_body
    request.body.rewind
    JSON.parse(request.body.read)
  rescue JSON::ParserError
    raise "Body is not a valid JSON!"
  end

  get "/countries" do
    COUNTRIES.to_json
  end

  post "/create_payment" do
    body = parse_body
    store = PaymentGatewayStore.new
    payments = store.get_all_payments
    raise "Body is not an object!" unless body.is_a?(Hash)
    raise "ID is invalid!" if body["id"].nil?
    raise "Duplicate payment ID!" if payments.any? { |p| p["id"].to_s == body["id"].to_s }
    config = COUNTRIES.find { |c| c["name"] == body["country"] }
    raise "Country is invalid!" if config.nil?
    raise "Currency is invalid!" unless config["currencies"].include?(body["currency"])
    raise "Fields is not an array!" unless body["fields"].is_a?(Array)
    config["fields"].each do |fcfg|
      fid = fcfg["id"]
      raise "Field '#{fid}' is invalid!" if body["fields"].count { |f| f["id"] == fid && !f["value"].nil? } != 1
    end
    raise "Amount is invalid!" unless body["amount"].to_s.to_d > 0
    store.add_new_payment body
    "OK".to_json
  end

  get "/payments_made" do
    PaymentGatewayStore.new.get_all_payments.to_json
  end

  error do
    env["sinatra.error"].message.to_json
  end
end

COUNTRIES =
  [
    {
      "name" => "France",
      "currencies" => [
        "EUR"
      ],
      "fields" => [
        {
          "id" => "recipient_full_name",
          "name" => "Recipient full name"
        },
        {
          "id" => "recipient_phone",
          "name" => "Recipient phone"
        }
      ]
    },
    {
      "name" => "Russia",
      "currencies" => [
        "RUB",
        "EUR",
        "USD"
      ],
      "fields" => [
        {
          "id" => "recipient_passport_id",
          "name" => "Recipient passport ID"
        },
        {
          "id" => "recipient_full_name",
          "name" => "Recipient full name"
        }
      ]
    },
    {
      "name" => "Romania",
      "currencies" => [
        "RON",
        "EUR"
      ],
      "fields" => [
        {
          "id" => "recipient_passport_id",
          "name" => "Recipient passport ID"
        },
        {
          "id" => "recipient_full_name",
          "name" => "Recipient full name"
        },
        {
          "id" => "recipient_address",
          "name" => "Recipient address"
        }
      ]
    }
  ]
