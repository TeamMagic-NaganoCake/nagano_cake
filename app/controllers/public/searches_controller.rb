class Public::SearchesController < ApplicationController

  def search
    @genres      = Genre.all
    model        = params[:model]
    @search_name = params[:content]
    if model    == "genre"
      @items     = Kaminari.paginate_array(Genre.search_for(@search_name)).page(params[:page]).per(8)
    elsif model == "item"
       @items    = Kaminari.paginate_array(Item.search_for(@search_name)).page(params[:page]).per(8)
    else
      @item      = Item.all
    end
  end

end
