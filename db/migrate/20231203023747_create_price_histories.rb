class CreatePriceHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :price_histories do |t|
      t.references :book, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
