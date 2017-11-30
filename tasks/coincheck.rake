require 'coinbase/wallet'
require './helpers/application_helper.rb'

include ApplicationHelper

coin_api_key = "G3YGHSXbnMzsBCEL"
coin_api_secret = "gD4QULNWNSO4PYYroy1XiGIvaANdVpDq"

namespace :coinbase do
  task :coincheck do
    client = Coinbase::Wallet::Client.new(api_key: coin_api_key, api_secret: coin_api_secret)
    updated = false

    # if rates exist in redis, load rates from redis, else load from database
    rates = load_rates

    # Load new rates from API. Would update to database if the rates change 
    rates.each do |r|
      rate = OpenStruct.new(r)
      new_rate = client.exchange_rates(currency: rate.origin_currency).rates[rate.exchanged_currency].to_i
      old_rate = rate.rate
      if (new_rate != old_rate)
        update_price(rate.origin_currency, rate.exchanged_currency, new_rate)
        r[:rate] = new_rate
        updated = true
      end
    end

    # Update new rates to redis
    if updated
      update_redis(rates)
    end
  end
end