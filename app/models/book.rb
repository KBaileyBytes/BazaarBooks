class Book < ApplicationRecord
  belongs_to :author
  has_many :price_histories
  has_many :order_items
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :book_formats
  has_many :formats, through: :book_formats
end
