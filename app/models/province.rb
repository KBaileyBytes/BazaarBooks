class Province < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true
  validates :pst, presence: true
  validates :gst, presence: true
  validates :hst, presence: true
end
