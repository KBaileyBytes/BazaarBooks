class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :order_status, presence: true
  validates :payment_status, presence: true
  validates :payment_method, presence: true
end
