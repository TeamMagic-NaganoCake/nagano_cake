class Admin::OrdersController < ApplicationController
  def index
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.page(params[:page])
  end
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.order_status == 1
      @order.order_items.manufacture_status = 1
      redirect_to admin_order_item_path(@order.order_items)
    end
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
