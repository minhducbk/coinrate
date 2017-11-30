require './config/redis'
require "./app"

module ApplicationHelper
  # if rates exist in redis, load rates from redis, else load from database 
  def load_rates
    rates = $redis.get("exchange_rates")
    if rates.nil?
      rates = update_redis
      # $redis.expire("snippets", 5.hour.to_i)
    end
    JSON.load rates
  end

  # Update new rate to database
  def update_price(origin_currency, exchanged_currency, price)
    rate = ExchangeRate.find_by(origin_currency: origin_currency, exchanged_currency: exchanged_currency)
    rate.update_columns(rate: price)
  end   

  # Update new rates to redis
  def update_redis
    rates = ExchangeRate.all.to_json
    $redis.set("exchange_rates", rates)
    rates
  end
end
