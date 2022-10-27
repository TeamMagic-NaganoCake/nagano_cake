class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  private
  def item_params
    params.require(:item).permit(:item_image, :item_name, :item_body, :genre_id, :none_taxed_price, :sale_status)
  end
end