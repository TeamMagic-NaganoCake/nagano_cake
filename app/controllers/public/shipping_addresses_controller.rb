class Public::ShippingAddressesController < ApplicationController
  def index
    @address = ShippingAddress.new
  end

  def edit
  end

  def create
    @address = ShippingAddress.new(shipping_addresses_params)
    if @address.save
      redirect_to shipping_addreses_path, notice: "配送先が追加されました。"
    else
      render :index
    end
  end

  def update
  end

  def destroy
  end

  private
    def shipping_addresses_params
      params.reqire(:shippig_addresses).permit(:postcode, :address, :address_name)
    end

end
