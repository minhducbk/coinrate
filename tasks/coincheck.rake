require 'coinbase/wallet'
require './helpers/application_helper.rb'

include ApplicationHelper

coin_api_key = "G3YGHSXbnMzsBCEL"
coin_api_secret = "gD4QULNWNSO4PYYroy1XiGIvaANdVpDq"
namespace :coinbase do
  task :coincheck do
    client = Coinbase::Wallet::Client.new(api_key: coin_api_key, api_secret: coin_api_secret)
    updated = false
    rates = load_rates
    rates.each do |r|
      rate = OpenStruct.new(r)
      new_rate = client.exchange_rates(currency: rate.origin_currency).rates[rate.exchanged_currency]
      old_rate = rate.price
      if (new_rate != old_rate)
        update_price(rate.origin_currency, rate.exchanged_currency, new_rate)
        updated = true
      end
    end
    if updated
      update_redis
    end
  end
end