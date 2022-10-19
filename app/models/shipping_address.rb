class ShippingAddress < ApplicationRecord

  validates :postcode, presence: :ture
  validates :address, presence: :ture
  validates :address_name, presence: :true


  belongs_to :customer
end
