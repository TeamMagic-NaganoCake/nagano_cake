class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0){|sum, item| sum + item.item_total_price}
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    if current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      @cart_item.amount = @cart_item.amount + cart_item_params[:amount].to_i
      if @cart_item.save
        redirect_to cart_items_path
      else
       @item = Item.find(cart_item_params[:item_id])
        render "public/items/show"
      end
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path
      else
        @item = Item.find(cart_item_params[:item_id])
        render "public/items/show"
      end
    end

  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
