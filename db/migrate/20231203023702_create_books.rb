class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.references :author, null: false, foreign_key: true
      t.decimal :average_rating
      t.integer :page_count
      t.string :title
      t.string :isbn
      t.decimal :price

      t.timestamps
    end
  end
end
