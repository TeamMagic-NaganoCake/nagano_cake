class ShippingAddress < ApplicationRecord

  validates :postcode, presence: :ture, format: {with:/\A\d{7}\z/, message: "７桁で入力してください"}
  validates :address, presence: :ture
  validates :address_name, presence: :true


  belongs_to :customer
end
