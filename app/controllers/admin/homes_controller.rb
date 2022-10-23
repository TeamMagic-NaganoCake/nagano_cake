class Admin::HomesController < ApplicationController
  layout "admin_application"
  def top
    @orders = Order.page(params[:page])

  end
end
