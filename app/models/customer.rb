class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/,message: "漢字・ひらがなのどちらかで入力して下さい"}
  validates :first_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/, message: "漢字・ひらがなのどちらかで入力して下さい"}
  validates :last_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "全角カタカナのみで入力して下さい"}
  validates :first_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "全角カタカナのみで入力して下さい"}
  validates :postcode, presence: :ture, format: {with:/\A\d{7}\z/, message: "７桁で入力してください"}
  validates :address, presence: :ture
  validates :phone_number, presence: :ture, format:{ with:/\A\d{10,11}\z/, message: "固定電話の場合は市街地局番から入力してください"}
  validates :customer_status, inclusion: {in: [true, false]}


  has_many :shipping_addresses
  has_many :orders
  has_many :cart_items, dependent: :destroy

def get_status
    if customer_status == false
       "有効"
    else
       "退会"
    end
 end

 #退会済みユーザーの識別
 def active_for_authentication?
  super && (self.customer_status == false)
 end

end
