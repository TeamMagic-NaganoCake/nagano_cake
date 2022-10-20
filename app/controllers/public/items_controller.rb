class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page])
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:item_image, :item_name, :item_body, :genre_id, :none_taxed_price, :sale_status)
  end
end
