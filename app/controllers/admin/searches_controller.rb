class Admin::SearchesController < ApplicationController
  layout "admin_application"
  def search
   @search_name = params[:content]
   @items = Kaminari.paginate_array(Item.search_for(@search_name)).page(params[:page])
  end
end
