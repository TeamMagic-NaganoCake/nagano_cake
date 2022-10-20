class Order < ApplicationRecord
  has_many :order_items
  belongs_to :customer
  has_many :items, through: :order_items
  enum payment: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_for_payment: 0, payment_comfirmation: 1, producting: 2, shipping_preparation: 3, shipped: 4 }
end
