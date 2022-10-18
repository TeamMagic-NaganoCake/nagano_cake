class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum manufacture_status: { impossible_to_manufacture: 0, waiting_for_manufacture: 1, manufacturing: 2, manufactured: 3 }
end
