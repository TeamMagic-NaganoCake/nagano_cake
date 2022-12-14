class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_application"
  
  def update
    @order_item  = OrderItem.find(params[:id])
    @order       = @order_item.order
    @order_items = @order.order_items.all
    @order_item.update(order_item_params)
    if @order_items.find_by(manufacture_status: "manufacturing")
      @order.update(order_status: "producting")
    elsif @order_items.where(manufacture_status: "manufactured").count == @order_items.count
      @order.update(order_status: "shipping_preparation")
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:manufacture_status)
  end
  
end
