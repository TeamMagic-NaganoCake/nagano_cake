class Public::SearchesController < ApplicationController
  def search
    @genre_name = params[:content]
    @genres = Genre.all
    @items = Kaminari.paginate_array(Genre.search_for(params[:content])).page(params[:page])
  end
end
