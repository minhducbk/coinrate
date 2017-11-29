require './config/redis'
require "./app"

module ApplicationHelper
  def load_rates
    rates = $redis.get("exchange_rates")
    if rates.nil?
      rates = update_redis
      # $redis.expire("snippets", 5.hour.to_i)
    end
    JSON.load rates
  end

  def update_price(origin_currency, exchanged_currency, price)
    rate = ExchangeRate.find_by(origin_currency: origin_currency, exchanged_currency: exchanged_currency)
    rate.update_columns(rate: price)
  end   

  def update_redis
    rates = ExchangeRate.all.to_json
    $redis.set("exchange_rates", rates)
    rates
  end
end
