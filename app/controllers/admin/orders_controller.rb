class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.all.page(params[:page])
  end

  def update
  end
end
