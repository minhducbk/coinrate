require './app.rb'

class ExchangeRate < ActiveRecord::Base
  validates :origin_currency, uniqueness: { scope: :exchanged_currency}
end
