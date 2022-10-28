class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @shipping_address   = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses.all
  end

  def edit
    @shipping_address   = ShippingAddress.find(params[:id])
  end

  def create
    @shipping_address = current_customer.shipping_addresses.new(shipping_address_params)
    @shipping_addresses = current_customer.shipping_addresses.all
    if @shipping_address.save
      flash[:notice]  = "配送先が追加されました。"
    else
      render :create_error
    end
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path
      flash[:notice]  = "配送先編集が完了しました。"
    else
      render :edit
    end

  end

  def destroy
    @shipping_addresses = current_customer.shipping_addresses.all
    shipping_address    = ShippingAddress.find(params[:id])
    shipping_address.destroy
    flash[:notice]      = "配送先削除が完了しました。"
  end

  private

    def shipping_address_params
      params.require(:shipping_address).permit(:postcode, :address, :address_name)
    end

end
