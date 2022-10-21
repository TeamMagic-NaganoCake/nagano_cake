class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = current_customer.orders.new
  end

  def confirm
    select_address = params[:order][:select_address]
    @order = current_customer.orders.new(order_params)
    if select_address == "0"
      @order.order_postcode = current_customer.postcode
      @order.order_address = current_customer.address
      @order.order_address_name = current_customer.last_name + current_customer.first_name
    elsif select_address == "1"
      @shipping_address = ShippingAddress.find(params[:order][:address_id])
      @order.order_postcode = @shipping_address.postcode
      @order.order_address = @shipping_address.address
      @order.order_address_name = @shipping_address.address_name
    else
      unless params[:order][:order_postcode].empty? || params[:order][:order_address].empty? ||  params[:order][:order_address_name].empty?
        @order.order_postcode = params[:order][:order_postcode]
        @order.order_address = params[:order][:order_address]
        @order.order_address_name = params[:order][:order_address_name]
      else
        render :new
      end
    end

    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0){|sum, item| sum + item.item_total_price}
    @order.postage = 800
    @order.billing_price = @total + @order.postage
  end

  def finish
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.postage = 800
    @order.billing_price = params[:order][:billing_price]
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_item = @order.order_items.new(item_id: cart_item.item.id, nochange_taxed_price: cart_item.item.taxed_price, amount: cart_item.amount)
      @order_item.save
    end
    @cart_items.destroy_all
    redirect_to orders_finish_path
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment, :order_postcode, :order_address, :order_address_name)
  end
end
