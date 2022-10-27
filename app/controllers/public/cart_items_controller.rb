class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items  = current_customer.cart_items.all
    @total_price = CartItem.total_price(current_customer)
  end

  def update
    @cart_item   = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @total_price = CartItem.total_price(current_customer)
  end

  def destroy
    @cart_item   = CartItem.find(params[:id])
    @cart_items  = current_customer.cart_items.all
    @cart_item.destroy
    @total_price = CartItem.total_price(current_customer)
    unless @cart_items.exists?
      redirect_to cart_items_path
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    if current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      if cart_item_params[:amount].empty?
        @item      = Item.find(cart_item_params[:item_id])
        @genres    = Genre.all
        @cart_item = CartItem.new
        @cart_item.errors[:base] <<  "個数を入力してください"
        render "public/items/show"
      else
        @cart_item        = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
        @cart_item.amount = @cart_item.amount + cart_item_params[:amount].to_i
        @cart_item.save
        redirect_to cart_items_path
      end
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path
      else
        @item   = Item.find(cart_item_params[:item_id])
        @genres = Genre.all
        render "public/items/show"
      end
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
