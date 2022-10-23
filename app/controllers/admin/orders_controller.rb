class Admin::OrdersController < ApplicationController
  def index
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.page(params[:page]).order(created_at: :desc)
  end
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def update
    order = Order.find(params[:id])

    order.update(order_params)
    if  order.order_status == "payment_comfirmation"
      order.order_items.update_all(manufacture_status: 1)
    end
    redirect_to admin_order_path(order)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
