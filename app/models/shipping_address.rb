class ShippingAddress < ApplicationRecord

  validates :postcode, presence: :ture
  validates :address, presence: :ture, format: {with:/\A\d{7}\z/, message: "７桁で入力してください"}
  validates :address_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/,message: "漢字・ひらがなのどちらかで入力して下さい"}


  belongs_to :customer
end
