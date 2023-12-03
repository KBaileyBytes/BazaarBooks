class Format < ApplicationRecord
  has_many :book_formats
  has many :books, through: :book_formats
end
