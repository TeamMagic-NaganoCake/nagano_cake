class Public::OrdersController < ApplicationController
  def new
  end

  def confirm
  end

  def finish
  end

  def create
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @orders = current_customer.orders
    @order_items = @orders.order_items
  end
end
