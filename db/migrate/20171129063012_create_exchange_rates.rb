class CreateExchangeRates < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_rates do |t|
      t.string :origin_currency
      t.string :exchanged_currency
      t.integer :rate

      t.timestamps
    end
  end
end
